## GGPLOT script for ploting chromosomes as lines, and the location of snps or genes as dots along those lines


library(ggplot2)

#biocLite("snpStats")

Ztritici_karyotype <- read.table("~/Bin/circos-0.62-1/example/Z.tritici/Ztritici_karyotype.txt", quote="\"")
ztk<-as.data.frame(Ztritici_karyotype[,4:7])
ztk$V4<-factor(ztk$V4, labels=c("chr_1","chr_2", "chr_3", "chr_4", "chr_5","chr_6", "chr_7","chr_8","chr_9","chr_10", "chr_11", "chr_12", "chr_13", "chr_14", "chr_15", "chr_16", "chr_17", "chr_18", "chr_19", "chr_20", "chr_21"))
class(ztk$V4)
View(ztk)
he<-c("Chromosome","Start","Stop")
NoMapRegions <- read.delim("~/Desktop/illuminamapred_less50.bed", sep="\t", header=F)
View(NoMapRegions)
names(NoMapRegions)<-he
levels(NoMapRegions$Chromosome)

#View(GGordered)

NoMapRegions$Chromosome <- factor(NoMapRegions$Chromosome, levels=c("chr_1","chr_2", "chr_3", "chr_4", "chr_5","chr_6", "chr_7","chr_8","chr_9","chr_10", "chr_11", "chr_12", "chr_13","chr_14","chr_15","chr_16","chr_17","chr_18","chr_19","chr_20","chr_21"))
levels(NoMapRegions$Chromosome)

ccbed<- NoMapRegions[NoMapRegions$Chromosome=="chr_1"|NoMapRegions$Chromosome=="chr_2"|NoMapRegions$Chromosome=="chr_3"|NoMapRegions$Chromosome=="chr_4"|NoMapRegions$Chromosome=="chr_5"|NoMapRegions$Chromosome=="chr_6"|NoMapRegions$Chromosome=="chr_7"|NoMapRegions$Chromosome=="chr_8"|NoMapRegions$Chromosome=="chr_9"|NoMapRegions$Chromosome=="chr_10"|NoMapRegions$Chromosome=="chr_11"|NoMapRegions$Chromosome=="chr_12"|NoMapRegions$Chromosome=="chr_13",]
ccbed

acbed <- NoMapRegions[NoMapRegions$Chromosome=="chr_14" |NoMapRegions$Chromosome=="chr_15" | NoMapRegions$Chromosome=="chr_16"|NoMapRegions$Chromosome=="chr_17"|NoMapRegions$Chromosome=="chr_18"|NoMapRegions$Chromosome=="chr_19"|NoMapRegions$Chromosome=="chr_20"|NoMapRegions$Chromosome=="chr_21",]
acbed
#p <- ggplot(ztk, aes(x=V4, ymin=0 ,ymax=V6), size=3)
#p
#ggplot()+ geom_linerange(data=ztk[1:13,], aes(x=as.numeric(V4), ymin=0 ,ymax=V6), size=3) + coord_flip() + labs(title = "Distribution of High/Moderate Effect Genes", x="Coverage")+geom_point(data=GoodGenes, aes(x=Start, y=Chromosome, color=Effect), position=position_jitter(w=0.0,h=0.15))
#ggplot()+ geom_segment(data=ztk[1:13,], aes(x=0, xend=V6, y=V4,yend=V4), size=3)
#ggplot()+ geom_abline(data=ztk[1:13,], aes(intercept=as.numeric(V4), slope=0), size=3) + labs(title = "Distribution of High/Moderate Effect Genes", x="Coverage")

pcc<- ggplot(ztk)+geom_segment(data=ztk[1:13,], aes(x=0, xend=V6, y=V4,yend=V4), size=5, color="grey") + geom_segment(data=ccbed, aes(x=Start, xend=Stop, y=Chromosome, yend=Chromosome), size=6, color="red") +
geom_point(data=GoodGenes, aes(x=Start, y=Chromosome, color=Effect), position=position_jitter(w=0.0,h=0.15)) + labs(x="Length of Chromosome", y="Core Chromosomes",colour="Position of genes with SNP effect") 
pcc
pcc2<-pcc+ geom_text(data=ccbed)
pcc2

pac<- ggplot(ztk)+geom_segment(data=ztk[14:21,], aes(x=0, xend=V6, y=V4,yend=V4), size=5, color="lightblue") + geom_segment(data=acbed[], aes(x=Start, xend=Stop, y=Chromosome, yend=Chromosome), size=6, color="red")+ labs(x="Length of Chromosome", y="Accessory Chromosomes")+ legend()
pac



GoodGenes <- read.delim("~/Dropbox/Megans_Data/Zymoseptoria_tritici/Priority_Gene_List_Rinput.txt", sep="\t")
View(GoodGenes)
levels(GoodGenes$Chromosome)
GGordered<-GoodGenes[with(GoodGenes, order(Chromosome)),]
View(GGordered)

GGordered$Chromosome <- factor(GGordered$Chromosome, levels=c("chr_1","chr_2", "chr_3", "chr_4", "chr_5","chr_6", "chr_7","chr_8","chr_9","chr_10", "chr_11", "chr_12", "chr_13"))
levels(GoodGenes$Chromosome)

points<- ggplot(GoodGenes, aes(x=Start, y=Chromosome, color=Effect)) + geom_point(position=position_jitter(w=0.0,h=0.15))
points<- ggplot(GGordered, aes(x=Start, y=Chromosome, color=Effect)) + geom_point(position=position_jitter(w=0.0,h=0.15))

points


p <- ggplot(ztk, aes(x=V4, ymin=0 ,ymax=V6), size=3)
p
ggplot()+ geom_linerange(data=ztk[1:13,], aes(x=as.numeric(V4), ymin=0 ,ymax=V6), size=3) + coord_flip() + labs(title = "Distribution of High/Moderate Effect Genes", x="Coverage")+geom_point(data=GoodGenes, aes(x=Start, y=Chromosome, color=Effect), position=position_jitter(w=0.0,h=0.15))
ggplot()+ geom_segment(data=ztk[1:13,], aes(x=0, xend=V6, y=V4,yend=V4), size=3)
ggplot()+ geom_abline(data=ztk[1:13,], aes(intercept=as.numeric(V4), slope=0), size=3) + labs(title = "Distribution of High/Moderate Effect Genes", x="Coverage")


ggplot()+ geom_segment(data=ztk[1:13,], aes(x=0, xend=V6, y=V4,yend=V4), size=3, color="grey") + labs(title = "Distribution of High/Moderate Effect Genes", x="Mbp", y="Chromosomes")+geom_point(data=GoodGenes, aes(x=Start, y=Chromosome, color=Effect),position=position_jitter(w=0.0,h=0.15))


