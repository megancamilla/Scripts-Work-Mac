## Plotting in R with ggplot 2

## Start R
R
## load the ggplot library
library(ggplot2)


## Generate histograms using ggplot 2

## import tab-delimited bedgraph file, file does not contain a header line
WAI320cov <- read.delim("~/Genomes/GATK_Variant_Detection/CoveragePlots/WAI320.genomecovBed.bedgraph", header=F)

## generate a plot object using ggplot
p <- ggplot(WAI320cov, aes(x=V4)) 

## open a pdf device to write your plot to
pdf("WAI320_chromosomeCov.pdf", width=6, height=6)

### use print to write your plot to the open pdf document
### p is the basic plot + histogram (bin=width of bar used for counting) xlim is scale on x axis + labels for your axes
print(p + geom_histogram(bin=3) + xlim(0,100) + labs(title = "Genome Coverage WAI320", x="Coverage"))

## Turn off the pdf device
dev.off()


## import snp vcf file
WAI320_chr13snps <- read.delim("~/Genomes/MySQL_inputfiles/R.infile", header=F)

p <- ggplot(WAI320_chr13snps, aes(x=V3, fill=V4))

print(p + geom_histogram(bin=10000))



WAI320_chr5snps <- read.delim("~/Genomes/MySQL_inputfiles/R.chr_5.infile", header=F)
WAI321_chr5snps<-read.delim("~/Genomes/MySQL_inputfiles/R321.chr_5.infile", header=F)
both <-read.delim("~/Genomes/MySQL_inputfiles/320_321_chr5.txt", header=F)

WAI320[]

p <- ggplot(WAI320_chr5snps, aes(x=V3, color=V4))

p2 <- ggplot(WAI321_chr5snps, aes(x=V3, color=V4))
pboth<- ggplot(both, aes(x=V3, linetype=("",""), color=V4))

print(p +geom_freqpoly(bin=50000) +labs(title = "SNPs in Chr5 Exons", x="Position"))
print(p + geom_freqpoly(bin=100)+ xlim(1.975e6,2.0e6) +labs(title = "SNPs in Chr5 Exons", x="Position"))

print(pboth + geom_freqpoly(bin=50000) +labs(title = "SNPs in Chr5 Exons", x="Position"))
print(pboth +geom_freqpoly(bin=100000))


