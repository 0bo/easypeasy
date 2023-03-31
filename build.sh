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

# Build Polish version
(
    mkdir -p _book/pl
    cd translations/pl/
    Rscript -e "bookdown::render_book('index.Rmd', 'all')"
    cp -r _book/* ../../_book/pl/
)

# Build Swedish version
(
    mkdir -p _book/sv
    cd translations/sv/
    Rscript -e "bookdown::render_book('index.Rmd', 'all')"
    cp -r _book/* ../../_book/sv/
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
