FROM ghcr.io/giampaolomart/rstudio_docker:nightly

# Switch to root to install system dependencies
USER root

# Install necessary system dependencies and build tools
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
    build-essential \
    liblzma-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libgit2-dev \
    && apt-get clean

# Increase make jobs for better performance (root user)
RUN echo "MAKEFLAGS=-j4" >> /usr/local/lib/R/etc/Renviron.site

# Switch back to default user for RStudio
USER rstudio

# Install Bioconductor package manager
RUN R -e "install.packages('BiocManager', repos='http://cran.r-project.org')"

# Install necessary Bioconductor packages
RUN R -e "BiocManager::install(c('Rhtslib', 'Rsamtools', 'GenomicAlignments', 'rtracklayer'), ask = FALSE, verbose = TRUE)"

# Install scDblFinder (after dependencies are installed)
RUN R -e "BiocManager::install('scDblFinder', ask = FALSE, verbose = TRUE)"

# Expose RStudio port
EXPOSE 8787

# Default command to start RStudio
CMD ["/init"]

