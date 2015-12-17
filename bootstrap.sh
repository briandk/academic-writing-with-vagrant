# print start time
echo "DATE ||| $(date)"

# Variables
RSTUDIOVERSION='rstudio-server-0.99.824-amd64.deb'

# Try replacing the standard ubuntu archive with a faster mirror
sed -i.bak 's/archive.ubuntu.com/mirrors.rit.edu/' /etc/apt/sources.list

# Add CRAN mirror to apt-get sources
add-apt-repository "deb https://cran.rstudio.com/bin/linux/ubuntu trusty/"
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# install LaTeX, nodejs, R, and base Haskell
apt-get update && apt-get install --assume-yes --no-install-recommends \
    apache2 \
    cabal-install \
    ca-certificates \
    gdebi-core \
    git \
    libcurl4-openssl-dev \
    libmysqlclient-dev \
    libpq-dev \
    libpq5 \
    libxml2-dev \
    lmodern \
    nodejs \
    r-base \
    r-recommended \
    texlive-fonts-recommended \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-latex-recommended \
    texlive-luatex \
    texlive-xetex

# Install Pandoc and Pandoc-Citeproc
cabal update && cabal install pandoc pandoc-citeproc
ln -s /root/.cabal/bin/pandoc /usr/local/bin/pandoc
ln -s /root/.cabal/bin/pandoc-citeproc /usr/local/bin/pandoc-citeproc

# Get RStudio Server
if [ ! -e /usr/sbin/rstudio-server ]
    then
        echo "Installing RStudio Server"
          && wget https://s3.amazonaws.com/rstudio-dailybuilds/$RSTUDIOVERSION
          && gdebi --non-interactive $RSTUDIOVERSION
          && echo "RStudio server is running at http://localhost:4567"
fi

# Install R Dependencies
R --vanilla -f /vagrant/r-dependencies.R

# print end time
echo "DATE ||| $(date)"
