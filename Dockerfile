FROM ghcr.io/giampaolomart/rstudio_docker:nightly

# Temporarily switch to root to install system dependencies
USER root

# Install necessary system dependencies
RUN apt-get update && apt-get install -y \
    xz-utils \
    liblzma-dev \
    && apt-get clean

# Switch back to the default user for RStudio
USER rstudio

# Install Bioconductor package manager (BiocManager) and required packages
RUN R -e "install.packages('BiocManager', repos='http://cran.r-project.org')"
RUN R -e "BiocManager::install(c('Rhtslib', 'Rsamtools', 'GenomicAlignments', 'rtracklayer', 'scDblFinder'))"

# Expose RStudio port
EXPOSE 8787

# Set the default command to start RStudio Server
CMD ["/init"]

