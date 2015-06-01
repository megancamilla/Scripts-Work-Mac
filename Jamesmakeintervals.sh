#! /bin/bash

strain=`cat /Volumes/Solomon_Lab/Megan/GATK/isolatenames.txt`
for line in $strain
	do
	echo "-----------------Starting ISOLATE "$line"--------------------"
	bam=/Users/meganm/Genomes/GATK_Variant_Detection/$line.realign.bam
	ref=~/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa #prefer just numbers as chromosome IDs but can substitute later
	echo "----------------Generating bedgraph file ------------------"
	genomeCoverageBed -ibam $bam -g $ref.fai -bga > $line"_v_IPO323.bedgraph"
	echo "-----------------Parsing bedgraph file ------------------"
	awk '$4 >= 10' $line"_v_IPO323.bedgraph" | mergeBed -i stdin > $line"_v_IPO323_x10.bed"
 
#perl ~/scripts/make_intervals.pl $ref.fai 100000 IPO323_intervals_100kb.bed
	echo "--------------Generating histograms per 100kb -------------------"
	coverageBed -abam $bam -b IPO323_intervals_100kb.bed | awk {'print $1,$2,$3,$8'} > "IPO323_"$line"_100kb.hist"
	vcf=/Users/meganm/Genomes/GATK_Variant_Detection/JamesVCF/$line.gatk2-4.vcf
	cat $vcf | awk {'print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" $8 "\t" $9 "\t" $10'} > $vcf.temp
	echo "-------------Counting variants per 100kb------------------------"
	coverageBed -a $vcf.temp -b IPO323_intervals_100kb.bed | awk {'print $1,$2,$3,$5'} > "IPO323_"$line"_variants_100kb.hist"
	echo "---------------------FINISHED ISOLATE "$line"-----------------"
done

