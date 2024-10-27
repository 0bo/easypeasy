#!/bin/bash

# Install fonts
cp Arial.ttf /usr/local/share/fonts/
cp Dotum.ttf /usr/local/share/fonts/
fc-cache -fv
fc-list

# Install tinytex
Rscript -e "install.packages('tinytex')"
Rscript -e "tinytex::install_tinytex(force = TRUE)"

# Build EasyPeasy
Rscript -e "bookdown::render_book('index.Rmd', 'all')"

# Build EasyPeasy translations
buildpath=`pwd`
langs="de it sv ru so ro sq nl pt-br pl ko"
for lang in $langs
do
    mkdir -p _book/$lang
    cd translations/$lang



    ####################################
    # Rename the markdown headers
    ####################################
    
    backtick='`'
    newline=$'\n'
    
    rmdfiles=`ls -1 | grep -iE '\.rmd'`
    while IFS= read -r rmdfile
    do
        filecontent=`cat "$rmdfile"`
        newfilecontent=""
        while IFS= read -r fileline
        do
            lineisheader="0"
            headerisnamed="0"
            headerisunnumbered="0"
            if [[ "${fileline:0:1}" == "#" ]]
            then
                if grep -Po "^((#)|(##))( |\t).*$" <<< "$fileline" &> /dev/null
                then
                    lineisheader="1"
                    if grep -Po "^((#)|(##))( |\t).*{[ \t]{0,}#.*}[ \t]{0,}$" <<< "$fileline" &> /dev/null
                    then
                        headerisnamed="1"
                    fi
                    if grep -Po "^((#)|(##))( |\t).*{[ \t]{0,}-[ \t]{0,}[ \t]{0,}#.*}[ \t]{0,}$" <<< "$fileline" &> /dev/null
                    then
                        headerisnamed="1"
                    fi
                    if grep -Po "^((#)|(##))( |\t).*{[ \t]{0,}-[ \t]{0,}}[ \t]{0,}$" <<< "$fileline" &> /dev/null
                    then
                        headerisunnumbered="1"
                    fi
                fi
            fi
            if [ $lineisheader = 1 ] && [ $headerisnamed = 0 ]
            then
                headerunsignaled=`sed -e "s/{[ \t]\{0,\}-[ \t]\{0,\}}[ \t]\{0,\}$//g" <<< "$fileline"`
                headername=`sed -e "s/^((#)|(##))//g" <<< "$headerunsignaled"`
                sanitizedname=`sed -e "s/^\(\(#\)\|\(##\)\)//g" -e "s/[#\\\/?!.<>${backtick}',()&@%^$~{}+=;:\"|\*\x00-\x1F]//g" -e "s/\[//g" -e "s/]//g" -e "s/^[ \t]\+//g" -e "s/[ \t]\+$//g" -e "s/[ \t]\+/-/g" -e "s/[-]\+/-/g" -e "s/[[:upper:]]*/\L&/g" <<< "$headername"`
                if [ $headerisunnumbered = 0 ]
                then
                    newheader="$headerunsignaled {#${sanitizedname}}"
                else
                    newheader="$headerunsignaled {-#${sanitizedname}}"
                fi
                newfilecontent+="$newheader$newline"
            else
                newfilecontent+="$fileline$newline"
            fi
        done <<< "$filecontent"
        echo "$newfilecontent" > "$rmdfile"
    done <<< "$rmdfiles"
    
    ####################################
    # End of Rename the markdown headers
    ####################################



    Rscript -e "bookdown::render_book('index.Rmd', 'all')"
    cp -r _book/* ../../_book/$lang/
    cd $buildpath
done