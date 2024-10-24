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

log()
{
    logstrs+=("$@")
}

printlog()
{
    for ((i = 0; i < ${#logstrs[@]}; i++))
    do
        echo "${logstrs[$i]}"
    done
}

exit_err_printlog()
{
    printlog
    exit 1
}

for lang in $langs
do
    mkdir -p _book/$lang
    cd translations/$lang
    Rscript -e "bookdown::render_book('index.Rmd', 'all')"
    cp -r _book/* ../../_book/$lang/
    
    
    ############################
    # Rewrite the sidebar
    ############################
    
    log "get the html filenames in proper order by scraping the html nextpage attributes"
    curr="index.html"
    log "$curr"
    htmlfiles+=("$curr")
    while :
    do
        
        if [ ! -f "$curr" ]
        then
            log "error: file $curr does not exist"
            exit_err_printlog
        fi
        
        match=`grep -Po "(?<=<link rel=\"next\" href=\").+?(?=\"/>)" $curr`
        if [ $? -eq 0 ]
        then
            if [ `wc -l <<< "$match"` -ne 1 ]
            then
                log "error: more than one match"
                exit_err_printlog
            fi
            log "$match"
            htmlfiles+=("$match")
            curr="$match"
        else
            break
        fi
        
    done
    
    log "the array of filenames:"
    for ((i = 0; i < ${#htmlfiles[@]}; i++))
    do
        htmlfile="${htmlfiles[$i]}"
        log "item: $htmlfile"
    done
    
    log "scraping the html files for chapter and subchapter attributes"
    for ((i = 0; i < ${#htmlfiles[@]}; i++))
    do
        htmlfile="${htmlfiles[$i]}"
        
        matches=`cat $htmlfile | tr -d "\n\r" | grep -Po "class=\"section level(.*?)><h(1|2)>(.*?)</h"`
        if [ $? -ne 0 ]
        then
            log "error: match not found"
            exit_err_printlog
        fi
        
        while IFS= read -r line
        do
            
            match=`grep -Po "(?<=<h(1|2)>)(.*?)(?=<a href)" <<< "$line"`
            if [ $? -ne 0 ]
            then
                log "error: no match"
                exit_err_printlog
            fi
            if [ `wc -l <<< "$match"` -ne 1 ]
            then
                log "error: more than one match"
                exit_err_printlog
            fi
            name="$match"
            match=`grep -Po "(?<=</span> )(.*?)(?=<a href)" <<< "$line"`
            if [ $? -eq 0 ]
            then
                if [ `wc -l <<< "$match"` -ne 1 ]
                then
                    log "error: more than one match"
                    exit_err_printlog
                fi
                name="$match"
            fi
            match=`grep -Po "(<|>)" <<< "$line"`
            if [ $? -ne 0 ]
            then
                log "error: < or > in name"
                exit_err_printlog
            fi
            log "name \"$name\""
            names+=("$name")
            
            match=`grep -Po "class=\"section level(1|2) unnumbered hasAnchor\">" <<< "$line"`
            if [ $? -eq 0 ]
            then
                if [ `wc -l <<< "$match"` -ne 1 ]
                then
                    log "error: more than one match"
                    exit_err_printlog
                fi
                number="unnumbered"
            else
                match=`grep -Po "(?<=class=\"section level(1|2) hasAnchor\" number=\").+?(?=\">)" <<< "$line"`
                if [ $? -ne 0 ]
                then
                    log "error: no match"
                    exit_err_printlog
                fi
                if [ `wc -l <<< "$match"` -ne 1 ]
                then
                    log "error: more than one match"
                    exit_err_printlog
                fi
                number="$match"
            fi
            log "number \"$number\""
            numbers+=("$number")
            
            match=`grep -Po "(class=\"section level1 unnumbered hasAnchor\">)|(class=\"section level1 hasAnchor\" number=\"(.*?)\">)" <<< "$line"`
            if [ $? -eq 0 ]
            then
                if [ `wc -l <<< "$match"` -ne 1 ]
                then
                    log "error: more than one match"
                    exit_err_printlog
                fi
                level="level1"
            else
                match=`grep -Po "(class=\"section level2 unnumbered hasAnchor\">)|(class=\"section level2 hasAnchor\" number=\"(.*?)\">)" <<< "$line"`
                if [ $? -ne 0 ]
                then
                    log "error: no match"
                    exit_err_printlog
                fi
                if [ `wc -l <<< "$match"` -ne 1 ]
                then
                    log "error: more than one match"
                    exit_err_printlog
                fi
                level="level2"
            fi
            log "level \"$level\""
            levels+=("$level")
            
            match=`grep -Po "(?<=<a href=\")(.*?)(?=\")" <<< "$line"`
            if [ $? -ne 0 ]
            then
                log "error: no match"
                exit_err_printlog
            fi
            if [ `wc -l <<< "$match"` -ne 1 ]
            then
                log "error: more than one match"
                exit_err_printlog
            fi
            href="$match"
            log "href \"$href\""
            hrefs+=("$href")
            
        done <<< "$matches"
        
    done
    
    if [ ${#names[@]} -ne ${#numbers[@]} ] || [ ${#numbers[@]} -ne ${#levels[@]} ] || [ ${#levels[@]} -ne ${#hrefs[@]} ]
    then
        log "array length mismatch"
        exit_err_printlog
    fi
    
    log "the array of data:"
    for ((i = 0; i < ${#names[@]}; i++))
    do
        name="${names[$i]}"
        number="${numbers[$i]}"
        level="${levels[$i]}"
        href="${hrefs[$i]}"
        log "name: \"$name\" number: \"$number\" level: \"$level\" href: \"$href\""
    done
    
    log "building the html sidebar"
    firstiter="1"
    for ((i = 0; i < ${#names[@]}; i++))
    do
        name="${names[$i]}"
        number="${numbers[$i]}"
        level="${levels[$i]}"
        href="${hrefs[$i]}"
        
        if [ $firstiter = "0" ]
        then
            prefix="</li>"
        fi
        firstiter="0"
        
        sidebar+="$prefix<li class=\"chapter\" data-level=\"$number\" data-path=\"index.html\"><a href=\"$href\"><i class=\"fa fa-check\"></i><b>$number</b> $name</a>"
        
    done
    sidebar+="</li>"
    
    log "built sidebar"
    log "$sidebar"
    
    log "replacing the sidebar in the html files"
    for ((i = 0; i < ${#htmlfiles[@]}; i++))
    do
        htmlfile="${htmlfiles[$i]}"
        match=`grep -Po "<li class=\"divider\"></li>" "$htmlfile"`
        if [ $? -ne 0 ]
        then
            log "error: no match"
            exit_err_printlog
        fi
        if [ `wc -l <<< "$match"` -ne 2 ]
        then
            log "error: not two matches"
            exit_err_printlog
        fi
        
        sed -i "s@<li class=@<!-- <li class=@g" "$htmlfile"
        sed -i "s@<!-- <li class=\"divider\"></li>@<li class=\"divider\"></li> $sidebar <li class=\"divider\"></li> <!-- -->@g" "$htmlfile"
    done
    
    cd ..
    
    ############################
    # End of rewrite the sidebar
    ############################
    
    
    cd $buildpath
done