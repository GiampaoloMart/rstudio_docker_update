FROM ghcr.io/giampaolomart/rstudio_docker:nightly

# Set a writable temporary R library path for installation
ENV R_LIBS_USER=/tmp/R-site-library

# Create the writable directory
RUN mkdir -p $R_LIBS_USER && chmod 777 $R_LIBS_USER

# Install the Bioconductor package manager (BiocManager)
RUN R -e "install.packages('BiocManager', lib=Sys.getenv('R_LIBS_USER'), repos='http://cran.r-project.org')"

# Install the R packages, including scDblFinder and its dependencies
RUN R -e "BiocManager::install(c('Rhtslib', 'Rsamtools', 'GenomicAlignments', 'rtracklayer', 'scDblFinder'), lib=Sys.getenv('R_LIBS_USER'))"

# Move installed packages to the default library location
RUN mv $R_LIBS_USER/* /usr/local/lib/R/site-library/ && rm -rf $R_LIBS_USER

# Expose RStudio port
EXPOSE 8787

# Set the default command to start RStudio Server
CMD ["/init"]

