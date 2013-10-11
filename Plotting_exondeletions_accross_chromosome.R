## ggplot2 R code for plotting snp densities accross chromosomes


snps<-read.table("~/Genomes/GATK_Variant_Detection/CoveragePlots/WAI320.intersectexononlyzeroCOV_exonname.bed",sep="\t",header=F)
head(snps)
colnames(snps)<-c("chr","start","end","info1","chr2","info","exon", "exonstart", "exonstop", "info2", "strand", "codingframe","Transcript_info","sizeofzerocov")
snps$chr <- factor(snps$chr, levels=c("chr_1","chr_2", "chr_3", "chr_4", "chr_5","chr_6", "chr_7","chr_8","chr_9","chr_10", "chr_11", "chr_12", "chr_13", "chr_14", "chr_15", "chr_16", "chr_17", "chr_18", "chr_19", "chr_20", "chr_21"))

# Plot the densities of snps in the bed file for each chr seperately
library(ggplot2)
ggplot(snps) + 
  geom_histogram(aes(x=start), binwidth=10000) + # pick a binwidth that is not too small 
  facet_wrap(~ chr,ncol=4,scales= "free") + # seperate plots for each chr, x-scales can differ from chr to chr
  ggtitle("Density of Exon Deletion accros Z.tritici") +
  xlab("Position in the genome") + 
  ylab("SNP density") 

### Plot the exons missing one chromosome at a time

## subset your data by chromosome
snps[snps$chr=="chr_1",]

ggplot(snps[snps$chr=="chr_14",],aes(x=start)) + 
  geom_histogram(binwidth=5000) + # pick a binwidth that is not too small 
   # seperate plots for each chr, x-scales can differ from chr to chr
  scale_x_continuous(breaks=0:7e5) +
  ggtitle("Density of Exon Deletion accros Z.tritici") +
  xlab("Position on the Chromosome") + 
  ylab("Number of Exons Missing in 10 KB") 



