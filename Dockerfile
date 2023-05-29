FROM rocker/r-rmd:latest

# Install Ubuntu distributions of R Packages
RUN apt-get --allow-releaseinfo-change update \
	&& apt-get install -y --no-install-recommends \
    r-cran-here \
    r-cran-haven \
    r-cran-tidyverse \
    r-cran-devtools 

# Install R packages
RUN install2.r --error \
    table1 \
    patchwork \
    kableExtra

# Install R packages on GitHub
RUN R -e "devtools::install_github('achetverikov/apastats', subdir='apastats')"