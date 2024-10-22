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
for lang in "de it sv ru so ro sq nl pt-br pl ko"
do
    mkdir -p _book/$lang
    cd translations/$lang
    Rscript -e "bookdown::render_book('index.Rmd', 'all')"
    cp -r _book/* ../../_book/$lang/
    cd $buildpath
done