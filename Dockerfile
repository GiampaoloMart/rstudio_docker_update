FROM ghcr.io/giampaolomart/rstudio_docker:nightly

# Set up an alternative writable R library path for package installation
ENV R_LIBS_USER=/tmp/R-site-library

# Create the writable directory for temporary package installation
RUN mkdir -p $R_LIBS_USER && chmod 777 $R_LIBS_USER

# Install the Bioconductor package manager (BiocManager)
RUN R -e "install.packages('BiocManager', repos='http://cran.r-project.org')"

# Install the R packages, including scDblFinder and its dependencies
RUN R -e "BiocManager::install(c('Rhtslib', 'Rsamtools', 'GenomicAlignments', 'rtracklayer', 'scDblFinder'))"

# Clean up the temporary library
RUN rm -rf $R_LIBS_USER

# Expose RStudio port
EXPOSE 8787

# Set the default command to start RStudio Server
CMD ["/init"]

