# Install fonts
cp Arial.ttf /usr/local/share/fonts/
cp Dotum.ttf /usr/local/share/fonts/
fc-cache -fv
fc-list

# Install tinytex
Rscript -e "install.packages('tinytex')"
Rscript -e "tinytex::install_tinytex(force = TRUE)"

# Build EasyPeasy and translations
Rscript -e "bookdown::render_book('index.Rmd', 'all')"

buildtranslation()
{
    mkdir -p _book/$1
    cd translations/$1
    Rscript -e "bookdown::render_book('index.Rmd', 'all')"
    cp -r _book/* ../../_book/$1/
}

( buildtranslation de ) # German
( buildtranslation it ) # Italian
( buildtranslation sv ) # Swedish
( buildtranslation ru ) # Russian
( buildtranslation so ) # Somali
( buildtranslation ro ) # Romanian
( buildtranslation sq ) # Albanian
( buildtranslation nl ) # Dutch
( buildtranslation pt-br ) # Brazilian Portuguese
( buildtranslation pl ) # Polish
( buildtranslation ko ) # Korean
