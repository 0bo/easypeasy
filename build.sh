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
    Rscript -e "bookdown::render_book('index.Rmd', 'all')"



    #############################
    #Fix the HTML sidebars
    #############################
    cd _book
    htmlfiles=`ls -1 | grep -iE '\.hTml'`
    while IFS= read -r htmlfile
    do
        ullevel="0"
        firstul="1"
        matches=`grep -Po "(<ul class=\"summary\">)|(<ul)|(</ul)|(<li class=\"chapter.*)" "$htmlfile"`
        while IFS= read -r match
        do
            if [ "$ullevel" != "-1" ]
            then
                ulwasset="0"
                if [ "$match" = "<ul class=\"summary\">" ]
                then
                    ullevel="1"
                    ulwasset="1"
                fi
                
                if [ "$match" = "<ul" ]
                then
                    ullevel=$((ullevel+1))
                    ulwasset="1"
                fi
                
                if [ "$match" = "</ul" ]
                then
                    ullevel=$((ullevel-1))
                    if [ "$ullevel" = "0" ]
                    then
                        ullevel="-1"
                    fi
                    ulwasset="1"
                fi
                
                if [ "$ullevel" != "-1" ]
                then
                    if [ "$ulwasset" = "0" ]
                    then
                        hrefvalue=`grep -Po "(?<=a href=\")(.*?)(?=\")" <<< "$match"`
                        grep -Po "^#" <<< "$hrefvalue" > /dev/null 2>&1
                        if [ $? -ne 0 ]
                        then
                            properhrefvalue="$hrefvalue"
                            firstul="0"
                            if [ "$ullevel" = "1" ]
                            then
                                previousproperhrefvalue="$properhrefvalue"
                            fi
                            hrefwasproper="1"
                        else
                            if [ "$ullevel" = "1" ]
                            then
                                if [ "$firstul" = "1" ]
                                then
                                    properhrefvalue="index.html"
                                    firstul="0"
                                else
                                    properhrefvalue=`tr -d "#" <<< "$hrefvalue"`
                                    properhrefvalue+=".html"
                                fi
                                previousproperhrefvalue="$properhrefvalue"
                            fi
                            if [ "$ullevel" = "2" ]
                            then
                                properhrefvalue=`tr -d "#" <<< "$hrefvalue"`
                                properhrefvalue="$previousproperhrefvalue#$properhrefvalue"
                            fi
                            hrefwasproper="0"
                        fi
                        sed -i "s@$hrefvalue@$properhrefvalue@g" "$htmlfile"
                    fi
                fi
            fi
        done <<< "$matches"
    done <<< "$htmlfiles"
    cd ..
    #############################
    #End of fix the HTML sidebars
    #############################



    cp -r _book/* ../../_book/$lang/
    cd $buildpath
done