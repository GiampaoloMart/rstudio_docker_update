FROM ghcr.io/giampaolomart/rstudio_docker:nightly

# Set environment variables for R
ENV DEBIAN_FRONTEND=noninteractive

# Install required system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libncurses5-dev \
    libncursesw5-dev \
    build-essential \
    wget \
    git \
    && apt-get clean

# Install the Bioconductor package manager (BiocManager)
RUN R -e "install.packages('BiocManager')"

# Install the R packages including scDblFinder
RUN R -e "BiocManager::install(c('Rhtslib', 'Rsamtools', 'GenomicAlignments', 'rtracklayer', 'scDblFinder'))"

# Verify the installation
RUN R -e "library(scDblFinder); library(Rsamtools); library(rtracklayer); library(GenomicAlignments)"

# Expose RStudio port
EXPOSE 8787

# Set the default command to start RStudio Server
CMD ["/init"]
