FROM rocker/r-rmd:latest

# Install Ubuntu distributions of R Packages
RUN apt-get --allow-releaseinfo-change update \
	&& apt-get install -y --no-install-recommends \
    r-cran-here \
    r-cran-haven \
    r-cran-tidyverse \
    r-cran-devtools 

# Install R packages on GitHub
RUN R -e "devtools::install_github('achetverikov/apastats', subdir='apastats')"

# Install R packages
RUN install2.r --error \
    table1 \
    patchwork \
    kableExtra \
    papaja \
    ggtext \
    labelled

# Install apa6
RUN apt-get install -y --no-install-recommends texlive-bibtex-extra

RUN R -e "tinytex::tlmgr_update()"


RUN tlmgr init-usertree \
    && tlmgr repository add ftp://tug.org/historic/systems/texlive/2022/tlnet-final \
    && tlmgr repository list \ 
    # && tlmgr repository remove http://mirror.ctan.org/systems/texlive/tlnet \
    && tlmgr option repository ftp://tug.org/historic/systems/texlive/2022/tlnet-final \
    && tlmgr install apa6

RUN R -e "tinytex::install_tinytex(force = TRUE)"

RUN apt-get install -y texlive-publishers texlive-fonts-extra texlive-latex-extra texlive-humanities lmodern