source('lib.R')


# setwd('/Users/artgoldman/ArtFiles/HSE AMI/2nd_year/bioinf/half4/epicgen')

###

#NAME <- 'H3K4me3_ESE14.ENCFF469NFG.mm9'
NAME <- 'H3K4me3_ESE14.ENCFF469NFG.mm10'
#NAME <- 'H3K4me3_ESE14.ENCFF815JHD.mm9'
#NAME <- 'H3K4me3_ESE14.ENCFF815JHD.mm10'

###


bed_df <- read.delim(paste0(DATA_DIR, NAME, '.bed'), as.is = TRUE, header = FALSE)
colnames(bed_df) <- c('chrom', 'start', 'end', 'name', 'score')
bed_df$len <- bed_df$end - bed_df$start
head(bed_df)

bed_df <- bed_df %>%
  arrange(-len) %>%
  filter(len < 5000)

ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('len_hist.', NAME, '.filtered.png'), path = OUT_DIR)


bed_df %>%
  select(-len) %>%
  write.table(file=paste0(DATA_DIR, NAME, '.filtered.bed'),
              col.names = FALSE, row.names = FALSE, sep = '\t', quote = FALSE)
