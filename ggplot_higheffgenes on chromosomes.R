## GGPLOT script for ploting chromosomes as lines, and the location of snps or genes as dots along those lines


library(ggplot2)

biocLite("snpStats")

Ztritici_karyotype <- read.table("~/Bin/circos-0.62-1/example/Z.tritici/Ztritici_karyotype.txt", quote="\"")
ztk<-as.data.frame(Ztritici_karyotype[,4:7])
ztk$V4<-factor(ztk$V4, labels=c("chr_1","chr_2", "chr_3", "chr_4", "chr_5","chr_6", "chr_7","chr_8","chr_9","chr_10", "chr_11", "chr_12", "chr_13", "chr_14", "chr_15", "chr_16", "chr_17", "chr_18", "chr_19", "chr_20", "chr_21"))
class(ztk$V4)
View(ztk)

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

                   

