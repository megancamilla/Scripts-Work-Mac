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
