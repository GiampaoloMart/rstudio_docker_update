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
    libbz2-dev \
    autoconf \
    libtool \
    pkg-config \
    && apt-get clean

# Set environment paths for building libraries
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
ENV LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

# Switch back to default user for RStudio
USER rstudio

# Install Bioconductor package manager
RUN R -e "install.packages('BiocManager', repos='http://cran.r-project.org')"

# Install dependencies sequentially
RUN R -e "BiocManager::install('Rhtslib', ask = FALSE, verbose = TRUE)" && \
    R -e "BiocManager::install('Rsamtools', ask = FALSE, verbose = TRUE)" && \
    R -e "BiocManager::install('GenomicAlignments', ask = FALSE, verbose = TRUE)" && \
    R -e "BiocManager::install('rtracklayer', ask = FALSE, verbose = TRUE)" && \
    R -e "BiocManager::install('scDblFinder', ask = FALSE, verbose = TRUE)"

# Expose RStudio port
EXPOSE 8787

# Default command to start RStudio
CMD ["/init"]


