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

# # French Version
# mkdir -p _book/fr
# cd translations/fr/
# Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"
# cp -r _book/* ../../_book/fr/

# # Hugarian Version
# mkdir -p _book/hu
# cd translations/hu/
# Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"
# cp -r _book/* ../../_book/hu/
