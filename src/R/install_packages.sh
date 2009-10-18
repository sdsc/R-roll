# If install_packages.sh is present, the R roll Makefile invokes it after
# building and installing R, passing the installation root as its sole argument.
# This provides the opportunity to invoke R to install CRAN packages as part of
# the roll build.  This step could be taken instead in the Roll post section,
# but that would cause the packages to be installed and built on every target
# during installation, rather than once during the roll build.

PKGROOT=$1
yum -y install curl-devel

${PKGROOT}/bin/R --vanilla << END
repos <- getOption("repos")
repos["CRAN"] = "http://cran.stat.ucla.edu"
options(repos = repos)
install.packages('gam', dependencies = TRUE)
install.packages('gap', dependencies = TRUE)
install.packages('haplo.stats', dependencies = TRUE)
source("http://bioconductor.org/biocLite.R")
biocLite("KEGG.db")
biocLite("KEGGSOAP")
biocLite("biomaRt")
biocLite("org.Dm.eg.db")
install.packages('gene2pathway', dependencies = TRUE)
install.packages('GenABEL', dependencies = TRUE)
install.packages('gee', dependencies = TRUE)
install.packages('GWAF', dependencies = TRUE)
install.packages('kinship', dependencies = TRUE)
install.packages('lattice', dependencies = TRUE)
install.packages('nlme', dependencies = TRUE)
install.packages('survival', dependencies = TRUE)
END
