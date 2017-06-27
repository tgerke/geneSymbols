#######################################################################################
# get all of the currently named genes from biomaRt
#######################################################################################

#######################################################################################
# directory, packages

setwd("~/Dropbox/projects/githubRepos/geneSymbols")

#source("http://bioconductor.org/biocLite.R")
#biocLite("biomaRt")
library(biomaRt)

#######################################################################################

# open connection
ensembl <- useMart("ensembl", dataset="hsapiens_gene_ensembl")

# in case of forgotten attribute name
#att <- listAttributes(ensembl)
#att[1:75,] # we want "hgnc_symbol"

allsymbols <- getBM("hgnc_symbol", mart=ensembl)
dim(allsymbols)
head(allsymbols)

# all unique?
length(unique(allsymbols$hgnc_symbol))==nrow(allsymbols)

write.table(allsymbols, file="hgnc_symbols.txt", sep="\t", quote=FALSE, 
            row.names=FALSE, col.names=FALSE)

