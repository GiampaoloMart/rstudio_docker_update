FROM ghcr.io/giampaolomart/rstudio_docker:nightly

# Temporarily switch to root to install system dependencies
USER root

# Install necessary system dependencies
RUN apt-get update && apt-get install -y \
    xz-utils \
    liblzma-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libhdf5-dev \
    zlib1g-dev \
    libhdf5-serial-dev \
    hdf5-tools \
    gfortran \
    libpng-dev \
    libjpeg-dev \
    libnetcdf-dev \
    git \
    patch \
    libglpk-dev \
    && apt-get clean

# Switch back to the default user for RStudio
USER rstudio

# Install Bioconductor package manager (BiocManager)
RUN R -e "install.packages('BiocManager', repos='http://cran.r-project.org')"

# Install Bioconductor packages
RUN R -e "BiocManager::install(c('Rhtslib', 'Rsamtools', 'GenomicAlignments', 'rtracklayer'))"

# Install scDblFinder (after dependencies are correctly installed)
RUN R -e "BiocManager::install('scDblFinder')"

# Expose RStudio port
EXPOSE 8787

# Set the default command to start RStudio Server
CMD ["/init"]
