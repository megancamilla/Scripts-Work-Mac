#!/bin/sh

#  GATK_SelectVariants.sh
#  
#
#  Created by Megan McDonald on 16/05/13.
#
# 
if [ "$1" == "" ]
	then
	    echo "-----------------------------------------------------------------"
	    echo "USAGE:"
	    echo "Select variant from a VCF file based on Quality and Read Depth"
	    echo "Tool is GATK's Select Variants (NOTE: different from filter Variants)"
	    echo "Reference path may need to be specified differently in script:Current is ~/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa "
	    echo "Input is as follows"
	    echo "GATK_SelectVariants.sh /path/to/tritici.vcf 30 10"
	    echo "Specifices a vcf file a Variant quality call of 30 and a Read depth of at least 10"
	    echo "-----------------------------------------------------------------"
	    exit 1
	else
    VCFfile=$1
    QC=$2
    Depth=$3
    Reference=~/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa
    java -Xmx3g -jar ~/Bin/GATK/GenomeAnalysisTK.jar -T SelectVariants -R $Reference -V $VCFfile -o Ztritici.$QC.$Depth.filter.vcf -select "QUAL > $QC && DP > $Depth"
fi