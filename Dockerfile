FROM ghcr.io/giampaolomart/rstudio_docker:nightly

# Set environment variables for R
ENV DEBIAN_FRONTEND=noninteractive

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
