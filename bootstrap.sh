# print start time
echo "DATE ||| $(date)"

# Variables
RSTUDIOVERSION='rstudio-server-0.99.792-amd64.deb'

# Add CRAN mirror to apt-get sources
add-apt-repository "deb https://cran.rstudio.com/bin/linux/ubuntu wily/"
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# install LaTeX, nodejs, R, and base Haskell
apt-get update && apt-get install --assume-yes --no-install-recommends \
    ca-certificates \
    gdebi-core \
    git \
    haskell-platform \
    apache2 \
    libcurl4-openssl-dev \
    libghc-pandoc-citeproc-data \
    libghc-pandoc-citeproc-dev \
    libghc-pandoc-citeproc-doc \
    libghc-pandoc-dev \
    libmysqlclient-dev \
    libpq-dev \
    libpq5 \
    libxml2-dev \
    lmodern \
    nodejs \
    qpdf \
    r-base-dev \
    r-recommended \
    texlive-fonts-recommended \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-latex-recommended \
    texlive-luatex \
    texlive-xetex

# Install Pandoc dependencies
apt-get install --assume-yes \
  	libghc-aeson-dev \
  	libghc-array-dev \
  	libghc-base-dev \
  	libghc-base64-bytestring-dev \
  	libghc-binary-dev \
  	libghc-blaze-html-dev \
  	libghc-blaze-markup-dev \
  	libghc-bytestring-dev \
  	libghc-cmark-dev \
  	libghc-containers-dev \
  	libghc-data-default-dev \
  	libghc-deepseq-generics-dev \
  	libghc-directory-dev \
  	libghc-extensible-exceptions-dev \
  	libghc-filemanip-dev \
  	libghc-filepath-dev \
  	libghc-ghc-prim-dev \
  	libghc-haddock-library-dev \
  	libghc-highlighting-kate-dev \
  	libghc-hslua-dev \
  	libghc-HTTP-dev \
  	libghc-http-client-dev \
  	libghc-http-client-tls-dev \
  	libghc-http-types-dev \
  	libghc-JuicyPixels-dev \
  	libghc-mtl-dev \
  	libghc-network-dev \
  	libghc-network-uri-dev \
  	libghc-old-locale-dev \
  	libghc-old-time-dev \
  	libghc-pandoc-dev \
  	libghc-pandoc-types-dev \
  	libghc-parsec3-dev \
  	libghc-process-dev \
  	libghc-random-dev \
  	libghc-scientific-dev \
  	libghc-SHA-dev \
  	libghc-syb-dev \
  	libghc-tagsoup-dev \
  	libghc-temporary-dev \
  	libghc-texmath-dev \
  	libghc-text-dev \
  	libghc-time-dev \
  	libghc-unordered-containers-dev \
  	libghc-vector-dev \
  	libghc-wai-dev \
  	libghc-wai-extra-dev \
  	libghc-xml-dev \
  	libghc-yaml-dev \
  	libghc-zip-archive-dev \
  	libghc-zlib-dev

# Install pandoc-citeproc dependencies
apt-get install --assume-yes \
    libghc-aeson-dev \
    libghc-aeson-pretty-dev \
    libghc-attoparsec-dev \
    libghc-base-dev \
    libghc-bytestring-dev \
    libghc-containers-dev \
    libghc-data-default-dev \
    libghc-directory-dev \
    libghc-filepath-dev \
    libghc-ghc-prim-dev \
    libghc-hs-bibutils-dev \
    libghc-mtl-dev \
    libghc-old-locale-dev \
    libghc-pandoc-dev \
    libghc-pandoc-citeproc-dev \
    libghc-pandoc-types-dev \
    libghc-parsec3-dev \
    libghc-pretty-show-dev \
    libghc-process-dev \
    libghc-setenv-dev \
    libghc-split-dev \
    libghc-syb-dev \
    libghc-tagsoup-dev \
    libghc-temporary-dev \
    libghc-text-dev \
    libghc-text-icu-dev \
    libghc-time-dev \
    libghc-vector-dev \
    libghc-xml-conduit-dev \
    libghc-yaml-dev

# Install Pandoc and Pandoc-Citeproc
cabal update && cabal install pandoc pandoc-citeproc
ln -s /root/.cabal/bin/pandoc /usr/local/bin/pandoc
ln -s /root/.cabal/bin/pandoc-citeproc /usr/local/bin/pandoc-citeproc

# Get RStudio Server
if [ ! -e /usr/sbin/rstudio-server ]
    then
        echo "Installing RStudio Server"
        wget https://s3.amazonaws.com/rstudio-dailybuilds/$RSTUDIOVERSION
        gdebi --non-interactive $RSTUDIOVERSION
fi

R --vanilla -f /vagrant/r-dependencies.R

# Inform the user what's up
echo "RStudio server is running at http://localhost:4567"

# print end time
echo "DATE ||| $(date)"
