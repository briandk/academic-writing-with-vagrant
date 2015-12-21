# print start time
echo "DATE ||| $(date)"

# Variables
RSTUDIOVERSION='rstudio-server-0.99.824-amd64.deb'
RVERSION='R-latest'

# Try replacing the standard ubuntu archive with a faster mirror
sed -i.bak 's/archive.ubuntu.com/mirrors.rit.edu/' /etc/apt/sources.list

# Add CRAN mirror to apt-get sources
add-apt-repository "deb https://cran.rstudio.com/bin/linux/ubuntu trusty/"
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# install base Haskell and other dependencies
apt-get update && apt-get install --assume-yes --no-install-recommends \
    apache2 \
    cabal-install \
    ca-certificates \
    ccache \
    gdebi \
    ghc \
    git \
    libcurl4-openssl-dev \
    libmysqlclient-dev \
    libpq-dev \
    libssl-dev \
    libx11-dev \
    libxml2-dev \
    mysql-client \
    wget

# Install LaTeX
#   This package list was generated by running
#   `apt-cache depends texlive-full` and then excluding *-doc packages
apt-get install --assume-yes --no-install-recommends \
    texlive-lang-polish  \
    texlive-generic-extra  \
    psutils  \
    latex-beamer  \
    info  \
    texlive-lang-indic  \
    texlive-lang-spanish  \
    latex-sanskrit  \
    texlive-omega  \
    texlive-lang-cyrillic  \
    texlive-lang-english  \
    prosper  \
    fragmaster  \
    texlive-base  \
    texlive-lang-european  \
    latexdiff  \
    latex-xcolor  \
    texlive-lang-african  \
    texlive-math-extra  \
    texlive-metapost  \
    texlive-lang-portuguese  \
    texlive-science  \
    tex4ht  \
    texlive-fonts-extra  \
    texlive-lang-italian  \
    dvidvi  \
    texlive-extra-utils  \
    texlive-luatex  \
    texlive-bibtex-extra  \
    latex-cjk-all  \
    texlive-latex-base  \
    texlive-font-utils  \
    texlive-fonts-recommended  \
    xindy  \
    texlive-pstricks  \
    lmodern  \
    texlive-lang-french  \
    texlive-xetex  \
    purifyeps  \
    latexmk  \
    texlive-lang-german  \
    lacheck  \
    texlive-lang-arabic  \
    texlive-plain-extra  \
    cm-super  \
    feynmf  \
    chktex  \
    tipa  \
    texlive-latex-recommended  \
    texlive-binaries  \
    texlive-music  \
    texlive-generic-recommended  \
    texlive-formats-extra  \
    texlive-humanities  \
    texlive-latex-extra  \
    texlive-publishers  \
    texlive-games  \
    pgf  \
    tex-gyre  \
    texlive-lang-greek  \
    texinfo  \
    context  \
    dvipng  \
    lcdf-typetools  \
    texlive-pictures  \
    texlive-lang-czechslovak  \
    texlive-lang-cjk  \
    t1utils  \
    texlive-lang-other


# Install Pandoc and Pandoc-Citeproc
cabal update && cabal install pandoc pandoc-citeproc
ln -s /root/.cabal/bin/pandoc /usr/local/bin/pandoc
ln -s /root/.cabal/bin/pandoc-citeproc /usr/local/bin/pandoc-citeproc

# Get Build Dependencies for building R from source
apt-get update && apt-get build-dep --assume-yes \
    r-base \
    r-cran-rgl

# Build R from source
if [ ! -e /usr/local/bin/R ]
    then
        wget "https://cran.rstudio.com/src/base/$RVERSION.tar.gz" && \
        mkdir /$RVERSION && \
        tar --strip-components 1 -zxvf $RVERSION.tar.gz  -C /$RVERSION && \
        cd /$RVERSION && \
        ./configure --enable-R-shlib && \
        make && \
        make install
fi

# Install RStudio Server
if [ ! -e /usr/sbin/rstudio-server ]
    then
        echo "Installing RStudio Server"
        wget https://s3.amazonaws.com/rstudio-dailybuilds/$RSTUDIOVERSION
        gdebi --non-interactive $RSTUDIOVERSION
        echo "RStudio server is running at http://localhost:4567"
fi

# Install R Dependencies
R --vanilla -f /vagrant/r-dependencies.R

# print end time
echo "DATE ||| $(date)"
