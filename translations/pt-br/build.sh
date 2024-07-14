# Install fonts
cp Arial.TTF /usr/local/share/fonts/
fc-cache -fv

# Install tinytex
Rscript -e "install.packages('tinytex')"
Rscript -e "tinytex::install_tinytex(force = TRUE)"

# Build English version
Rscript -e "bookdown::render_book('index.Rmd', 'all')"

# Build German version
(
    mkdir -p _book/de
    cd translations/de/
    Rscript -e "bookdown::render_book('index.Rmd', 'all')"
    cp -r _book/* ../../_book/de/
)

# Build Italian version
(
    mkdir -p _book/it
    cd translations/it/
    Rscript -e "bookdown::render_book('index.Rmd', 'all')"
    cp -r _book/* ../../_book/it/
)

# Build Swedish version
(
    mkdir -p _book/sv
    cd translations/sv/
    Rscript -e "bookdown::render_book('index.Rmd', 'all')"
    cp -r _book/* ../../_book/sv/
)

# Build Russian version
(
    mkdir -p _book/ru
    cd translations/ru/
    Rscript -e "bookdown::render_book('index.Rmd', 'all')"
    cp -r _book/* ../../_book/ru/
)

# Build Somali version
(
    mkdir -p _book/so
    cd translations/so/
    Rscript -e "bookdown::render_book('index.Rmd', 'all')"
    cp -r _book/* ../../_book/so/
)

# Build Romanian version
(
    mkdir -p _book/ro
    cd translations/ro/
    Rscript -e "bookdown::render_book('index.Rmd', 'all')"
    cp -r _book/* ../../_book/ro/
)

# Build Albanian version
(
    mkdir -p _book/sq
    cd translations/sq/
    Rscript -e "bookdown::render_book('index.Rmd', 'all')"
    cp -r _book/* ../../_book/sq/
)

# Build Dutch version
(
    mkdir -p _book/nl
    cd translations/nl/
    Rscript -e "bookdown::render_book('index.Rmd', 'all')"
    cp -r _book/* ../../_book/nl/
)

# Build Brasil Portugueses version
(
    mkdir -p _book/pt-br
    cd translations/pt-br/
    Rscript -e "bookdown::render_book('index.Rmd', 'all')"
    cp -r _book/* ../../_book/pt-br/
)
