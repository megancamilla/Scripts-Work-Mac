#! /bin/bash

strain=`cat /Volumes/Solomon_Lab/Megan/GATK/isolatenames.txt`
## separate vcfs into individual GATK vcfs

echo "Splitting ISOLATE "$line"----------------------------------"
gatk=/Volumes/Solomon_Lab/Megan/GATK/01_snpeffCleanHaploid/Sift_Ztritici.CleanHaploidFilter.ud500.vcf
#1CHROM	1POS	3ID	4REF	5ALT	6QUAL	7FILTER	8INFO	9FORMAT	10WAI320	11WAI321	12WAI322	13WAI323	14WAI324	15WAI326	16WAI327	17WAI328	18WAI329	19st147	20st55	21st56	22st79
vcf-subset -c WAI320 -p $gatk > WAI320.cleanhaploidfilter.ud500.vcf
vcf-subset -c WAI321 -p $gatk > WAI321.cleanhaploidfilter.ud500.vcf
vcf-subset -c WAI322 -p $gatk > WAI322.cleanhaploidfilter.ud500.vcf
vcf-subset -c WAI323 -p $gatk > WAI323.cleanhaploidfilter.ud500.vcf
vcf-subset -c WAI324 -p $gatk > WAI324.cleanhaploidfilter.ud500.vcf
vcf-subset -c WAI326 -p $gatk > WAI326.cleanhaploidfilter.ud500.vcf
vcf-subset -c WAI327 -p $gatk > WAI327.cleanhaploidfilter.ud500.vcf
vcf-subset -c WAI328 -p $gatk > WAI328.cleanhaploidfilter.ud500.vcf
vcf-subset -c WAI329 -p $gatk > WAI329.cleanhaploidfilter.ud500.vcf
vcf-subset -c st147 -p $gatk > WAI147.cleanhaploidfilter.ud500.vcf
vcf-subset -c st55 -p $gatk > WAI55.cleanhaploidfilter.ud500.vcf
vcf-subset -c st56 -p $gatk > WAI56.cleanhaploidfilter.ud500.vcf
vcf-subset -c st79 -p $gatk > WAI332.cleanhaploidfilter.ud500.vcf

gatk=/Volumes/Solomon_Lab/Megan/GATK/01_snpeffCleanHaploid/Sift_Ztritici.CleanHaploidFilter.ud500.vcf
cat $gatk| grep '#' > headers.temp
cat $gatk | grep –v '#' | awk '{if ( ($4 =="A" && $5 == "G") || ($4 == "G" && $5 == "A") || ($4 == "C" && $5 == "T") || ($4 == "T" && $5 == "C") ) print $0}' > riplike.temp
cat headers.temp riplike.temp > riplike.vcf
x=1
for line in $strain
do
echo "-------------------------Make "$line" vcf----------------------"
cat $gatk |gawk '|grep -v "0:"
cat headers.temp isolate.temp >
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

