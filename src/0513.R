source('lib.R')


###
#NAME <- 'H3K4me3_ESE14.ENCFF469NFG.mm9'
#NAME <- 'H3K4me3_ESE14.ENCFF469NFG.mm10'
#NAME <- 'H3K4me3_ESE14.ENCFF815JHD.mm9'
#NAME <- 'H3K4me3_ESE14.ENCFF815JHD.mm10'
#NAME <- 'mouseZ-DNA2-cut'
NAME <- 'H3K4me3_ESE14.intersect.ZDNA2'
###

bed_df <- read.delim(paste0(DATA_DIR, NAME, '.bed'), as.is = TRUE, header = FALSE)
#colnames(bed_df) <- c('chrom', 'start', 'end', 'name', 'score')
colnames(bed_df) <- c('chrom', 'start', 'end')
bed_df$len <- bed_df$end - bed_df$start
head(bed_df)

# hist(bed_df$len)

ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('len_hist.', NAME, '.png'), path = OUT_DIR)
