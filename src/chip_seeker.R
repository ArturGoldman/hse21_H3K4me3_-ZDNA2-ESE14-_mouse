
source('lib.R')

###

# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
 #BiocManager::install("TxDb.Hsapiens.UCSC.hg19.knownGene")
#BiocManager::install("ChIPseeker")
#BiocManager::install("TxDb.Mmusculus.UCSC.mm10.knownGene", force=TRUE)
# BiocManager::install("clusterProfiler")
#BiocManager::install("GenomicFeatures", force=TRUE)
#install.packages("dplyr")
#BiocManager::install("org.Hs.eg.db")
 
library(ChIPseeker)
#library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(TxDb.Mmusculus.UCSC.mm10.knownGene)
library(clusterProfiler)

###

NAME <- 'H3K4me3_ESE14.ENCFF469NFG.mm10'
#NAME <- 'H3K4me3_ESE14.ENCFF815JHD.mm10'
BED_FN <- paste0(DATA_DIR, NAME, '.bed')

###

txdb <- TxDb.Mmusculus.UCSC.mm10.knownGene

peakAnno <- annotatePeak(BED_FN, tssRegion=c(-3000, 3000), TxDb=txdb, annoDb="org.Hs.eg.db")

pdf(paste0(OUT_DIR, 'chip_seeker.', NAME, '.plotAnnoPie.pdf'))
plotAnnoPie(peakAnno)
dev.off()

peak <- readPeakFile(BED_FN)
pdf(paste0(OUT_DIR, 'chip_seeker.', NAME, '.covplot.pdf'))
covplot(peak, weightCol="V5")
dev.off()

