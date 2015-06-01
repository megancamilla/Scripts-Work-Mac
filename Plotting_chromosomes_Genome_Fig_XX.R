## GGPLOT script for ploting chromosomes as lines, and the location of snps or genes as dots along those lines


library(ggplot2)


Ztritici_karyotype <- read.table("~/Bin/circos-0.62-1/example/Z.tritici/Ztritici_karyotype.txt", quote="\"")
ztk<-as.data.frame(Ztritici_karyotype[,4:7])
ztk$V4<-factor(ztk$V4, labels=c("chr_1","chr_2", "chr_3", "chr_4", "chr_5","chr_6", "chr_7","chr_8","chr_9","chr_10", "chr_11", "chr_12", "chr_13", "chr_14", "chr_15", "chr_16", "chr_17", "chr_18", "chr_19", "chr_20", "chr_21"))
class(ztk$V4)
head(ztk)

#GoodGenes <- read.delim("~/Dropbox/Megans_Data/Zymoseptoria_tritici/Priority_Gene_List_Rinput.txt", sep="\t")
#head(GoodGenes)

#### Import P/A genes
PDS<- read.delim("/Volumes/Solomon_Lab/Megan/Spades_assembly/RRes_anno_pres_absence/RR_blast_PA_forR.txt", header=TRUE)
head(PDS)
PDS$Isolate<- factor(PDS$Isolate, levels=c("WAI55","WAI56","WAI147","WAI320","WAI321","WAI322","WAI323","WAI324","WAI326","WAI327","WAI328","WAI329","WAI332"))
### assign levels to genome and genes
PDS$PA<- factor(PDS$PA, levels=c("1","0"))
genelevel<-as.vector(PDS$Gene[1:10688])
PDS$Gene <-factor(PDS$Gene, levels=rev(genelevel))
PDS$Chrom <- factor(PDS$Chrom, levels=c("chr_1","chr_2", "chr_3", "chr_4", "chr_5","chr_6", "chr_7","chr_8","chr_9","chr_10", "chr_11", "chr_12", "chr_13", "chr_14", "chr_15", "chr_16", "chr_17", "chr_18", "chr_19", "chr_20", "chr_21"))

levels(PDS$Chrom)
levels(ztk$V4)
WAI320PA<- PDS[PDS$Isolate=="WAI320",]

he<-c("Chromosome","Start","Stop")
NoMapRegions <- read.delim("~/Desktop/illuminamapred_less50.bed", sep="\t", header=F)
names(NoMapRegions)<-he
View(NoMapRegions)
NoMapRegions$Chromosome <- factor(NoMapRegions$Chromosome, levels=c("chr_1","chr_2", "chr_3", "chr_4", "chr_5","chr_6", "chr_7","chr_8","chr_9","chr_10", "chr_11", "chr_12", "chr_13","chr_14","chr_15","chr_16","chr_17","chr_18","chr_19","chr_20","chr_21"))
levels(NoMapRegions$Chromosome)


## Import SNP ratio data set/ SNPs per gene

SPB<- read.table("/Volumes/Solomon_Lab/Megan/GATK/01_snpeffCleanHaploid/RR_snpEff/SNPsperBase_250less3cys_forR.txt", sep="\t", header=T)
head(SPB)
SPB$Isolate<- factor(SPB$Isolate, levels=c("WAI55","WAI56","WAI147","WAI320","WAI321","WAI322","WAI323","WAI324","WAI326","WAI327","WAI328","WAI329","WAI332"))
SPB$Chromosome<-factor(SPB$Chromosome, levels=c("chr_1","chr_2", "chr_3", "chr_4", "chr_5","chr_6", "chr_7","chr_8","chr_9","chr_10", "chr_11", "chr_12", "chr_13", "chr_14", "chr_15", "chr_16", "chr_17", "chr_18"))
recode<-as.vector(SPB$Gene[1:189])
SPB$Gene<-factor(SPB$Gene, levels=rev(recode))
levels(SPB$Gene)
class(SPB$Isolate)

## Import SNP ratio datase/ SNPsper gene for isolate WAI320 
WAI320snps<-read.table("/Volumes/Solomon_Lab/Megan/GATK/01_snpeffCleanHaploid/RR_snpEff/WAI320_allsnps_forR.txt", sep="\t", header=T)
head(WAI320snps)
WAI320snps$Chromosome<-factor(WAI320snps$Chromosome, levels=c("chr_1","chr_2", "chr_3", "chr_4", "chr_5","chr_6", "chr_7","chr_8","chr_9","chr_10", "chr_11", "chr_12", "chr_13", "chr_14", "chr_15", "chr_16", "chr_17", "chr_18", "chr_19", "chr_20", "chr_21"))

####Plots
#plot chromosomes only
p <- ggplot(ztk)+ geom_bar(aes(x=V4,y=V6), width=1, stat="identity", fill="white", colour="white") +coord_flip()
p

#plot Chromosomes and gene P/A for isolate WAI320
p <- ggplot(ztk)+ geom_bar(aes(x=V4,y=V6), width=1, stat="identity", fill="white", colour="white") +coord_flip() +
  labs(title = "Distribution Gene Presence Absence in WAI320", x="Chromosome")+
  geom_segment(data=WAI320PA, aes(x=Chrom, xend=Chrom, y=Start, yend=Stop, color=PA), size=4)
p

#plot Chromosomes and gene P/A and mappability
p <- ggplot(ztk)+ geom_bar(aes(x=V4,y=V6), width=1, stat="identity", fill="white", colour="white") +coord_flip() +
  labs(title = "Distribution Gene Presence Absence in WAI320", x="Chromosome")+
  geom_segment(data=WAI320PA, aes(x=Chrom, xend=Chrom, y=Start, yend=Stop, color=PA), size=4)+
  geom_segment(data=NoMapRegions, aes(x=Chromosome, xend=Chromosome, y=Start, yend=Stop, size=4), colour="black", alpha=0.5)
p


#plot Chromosomes with Geom segment instead of geom bar
snps_p<- ggplot()+ geom_segment(data=ztk[1:18,], aes(x=0, xend=V6, y=V4,yend=V4), size=10, colour="grey")

ggplot()+geom_segment(data=SPB[SPB$Chromosome=="chr_1",], aes(x=Start,xend=Stop, y=Isolate, yend=Isolate, color=SNPs.base),size=10)+
   theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), axis.line = element_line(colour = "black"))+
  scale_color_gradient2(low="red", high="blue", mid="green", midpoint=0.030)
ggplot()+geom_segment(data=SPB[SPB$Chromosome=="chr_2",], aes(x=Start,xend=Stop, y=Isolate, yend=Isolate, color=SNPs.base),size=10)+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), axis.line = element_line(colour = "black"))+
  scale_color_gradient2(low="red", high="blue", mid="green", midpoint=0.030)



### Plot SNPS for WAI320
ggplot()+geom_segment(data=WAI320snps[WAI320snps$Chromosome=="chr_11",], aes(x=Start,xend=(Start+1000), y=Isolate, yend=Isolate, color=SNPs_base),size=10)+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), axis.line = element_line(colour = "black"))+
  scale_color_gradient2(low="red", high="blue", mid="green", midpoint=0.050)+facet_wrap(~Chromosome)


