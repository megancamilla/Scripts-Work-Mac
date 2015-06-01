#! /bin/bash
## USAGE: Call script name followed by a txt file that contains a list of Prefixes for the isolate names

	ISOLATES=$1
	ISOLATELINE=`cat $ISOLATES`
	REFERENCE=/Volumes/Solomon_Lab/Megan/GATK/Mycosphaerella_graminicola.allmasked.fa
	
	for line in $ISOLATELINE
	  do
	echo "-----------------------------------------------------------------";
	echo "-------------- GATK2.4 Unified genotyper for "$line"-------------";
	echo "-----------------------------------------------------------------";
	java -Xmx28g -jar ~/Bin/GATK/GenomeAnalysisTK.jar -T UnifiedGenotyper -R $REFERENCE -I /Users/meganm/Genomes/GATK_Variant_Detection/$line.realign.bam -stand_call_conf 50.0 \
	-stand_emit_conf 10.0 -dcov 50 --genotype_likelihoods_model BOTH  -rf BadCigar -o $line.gatk2-4.vcf
	done

