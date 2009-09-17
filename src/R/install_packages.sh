PKGROOT=$1
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
