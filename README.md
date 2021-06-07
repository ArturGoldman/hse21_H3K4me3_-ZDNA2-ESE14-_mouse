# hse21_H3K4me3_-ZDNA2-ESE14-_mouse

Bioinformatics minor project. Epigenetics, histone modifications.

Genome version - mm10

GenomeBrowser session: https://genome.ucsc.edu/s/artgoldman/hse21_H3K4me3_ZDNA2-ESE14_mouse

# Results

## Location of ChiP-seq peaks

### ENCFF469NFG
Non-filtered

![alt text](https://github.com/ArturGoldman/hse21_H3K4me3_ZDNA2-ESE14_mouse/blob/main/images/len_hist.H3K4me3_ESE14.ENCFF469NFG.mm10.png)

Filtered

![alt text](https://github.com/ArturGoldman/hse21_H3K4me3_ZDNA2-ESE14_mouse/blob/main/images/len_hist.H3K4me3_ESE14.ENCFF469NFG.mm10.filtered.png)

![alt text](https://github.com/ArturGoldman/hse21_H3K4me3_ZDNA2-ESE14_mouse/blob/main/images/chip_seeker.H3K4me3_ESE14.ENCFF469NFG.mm10.plotAnnoPie.png)

### ENCFF815JHD

Non-filtered

![alt text](https://github.com/ArturGoldman/hse21_H3K4me3_ZDNA2-ESE14_mouse/blob/main/images/len_hist.H3K4me3_ESE14.ENCFF815JHD.mm10.png)

Filtered

![alt text](https://github.com/ArturGoldman/hse21_H3K4me3_ZDNA2-ESE14_mouse/blob/main/images/len_hist.H3K4me3_ESE14.ENCFF815JHD.mm10.filtered.png)

![alt text](https://github.com/ArturGoldman/hse21_H3K4me3_ZDNA2-ESE14_mouse/blob/main/images/chip_seeker.H3K4me3_ESE14.ENCFF815JHD.mm10.plotAnnoPie.png)


## Location of DNA secondary structure

![alt text](https://github.com/ArturGoldman/hse21_H3K4me3_ZDNA2-ESE14_mouse/blob/main/images/len_hist.mouseZ-DNA2-cut.png)

![alt text](https://github.com/ArturGoldman/hse21_H3K4me3_ZDNA2-ESE14_mouse/blob/main/images/chip_seeker.mouseZ-DNA2-cut.plotAnnoPie.png)

## Location of intersection between ChiP-seq peaks and DNA secondary structure

![alt text](https://github.com/ArturGoldman/hse21_H3K4me3_ZDNA2-ESE14_mouse/blob/main/images/len_hist.H3K4me3_ESE14.intersect.ZDNA2.png)

![alt text](https://github.com/ArturGoldman/hse21_H3K4me3_ZDNA2-ESE14_mouse/blob/main/images/chip_seeker.H3K4me3_ESE14.intersect.ZDNA2.plotAnnoPie.png)


Example of intersection

chr1:18537874-18537959

![alt text](https://github.com/ArturGoldman/hse21_H3K4me3_ZDNA2-ESE14_mouse/blob/main/screenshots/Screenshot%202021-06-01%20at%2022.15.03.png)

chr1:20432407-20432495

![alt text](https://github.com/ArturGoldman/hse21_H3K4me3_ZDNA2-ESE14_mouse/blob/main/screenshots/Screenshot%202021-06-01%20at%2022.15.51.png)


# Performed operations
Get files:
-   wget https://www.encodeproject.org/files/ENCFF815JHD/@@download/ENCFF815JHD.bed.gz
-   wget https://www.encodeproject.org/files/ENCFF469NFG/@@download/ENCFF469NFG.bed.gz

Cut columns:
- zcat ENCFF469NFG.bed.gz | cut -f1-5 > H3K4me3_ESE14.ENCFF469NFG.mm10.bed
- zcat ENCFF815JHD.bed.gz | cut -f1-5 > H3K4me3_ESE14.ENCFF815JHD.mm10.bed

Reverse mm10 to mm9 for training:
- wget https://hgdownload.cse.ucsc.edu/goldenpath/mm10/liftOver/mm10ToMm9.over.chain.gz
- chmod a+x liftOver
- echo H3K4me3_ESE14.ENCFF469NFG   >    \_prefix.txt
- echo H3K4me3_ESE14.ENCFF815JHD   >>    \_prefix.txt
- cat \_prefix.txt  |  xargs -tI{}   liftOver {}.mm10.bed   mm10ToMm9.over.chain.gz   {}.mm9.bed   {}.unmapped.bed

Filter reads with R: see src folder. Chosen threshold: 5000

Merge two reads into one:
- cat  \*.filtered.bed  |   sort -k1,1 -k2,2n   |   bedtools merge   >  H3K4me3_ESE14.merge.mm10.bed

I had issue with columns of mouseZ-DNA2.bed file, so i had to leave first 3 columns. Result can be found in file mouseZ-DNA2-cut.bed

Intersect ZDNA and Histone reads:
- bedtools intersect -a mouseZ-DNA2-cut.bed -b H3K4me3_ESE14.merge.mm10.bed > H3K4me3_ESE14.intersect.ZDNA2.bed

Turn mm10 to hg19:
- wget https://hgdownload.cse.ucsc.edu/goldenpath/mm10/liftOver/mm10ToHg19.over.chain.gz
- liftOver   H3K4me3_ESE14.intersect.ZDNA2.bed   mm10ToHg19.over.chain.gz  H3K4me3_ESE14_mm10tohg19.intersect.ZDNA2.bed   \_unmapped.txt
