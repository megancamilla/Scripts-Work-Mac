## Plot the number of genes missing on the Core and Accessory chromosomes


GD<- read.delim("/Volumes/Solomon_Lab/Megan/Spades_assembly/gdnablast_50percent/Percent_Genes_Missing.txt",header=T)

head(GD)
##Exclude All Category
GD1<-GD[11:30,]

GD1$Type<- factor(GD1$Type, levels=c("Core","Acces"))
head(GD1)
library(ggplot2)

GD1p1 <-ggplot(GD1, aes(x=Missing, y=Percent_Genes_Missing, fill=Type)) + geom_bar(stat="identity", position="dodge")+
  labs(x="Number of Isolates Missing a Gene", y="Percent of Genes Missing", title="Summary of Missing Annotated Genes")+
  scale_fill_manual(values=c("darkred","darkorange"), name="", labels=c("Core N=10,397", "Accessory N=667"))+scale_y_continuous(breaks=c(0.1,0.2,0.3,0.4,0.5))

GD1p1

