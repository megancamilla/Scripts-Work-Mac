#!/bin/sh
## Freebayes script to run SNP calling with all 9 genomes
#
#
#
## Created by Megan McDonald on 10/07/13
#
#
#

if [ "$1" == "" ]
    then
        echo " This is a bash script to run SNP calling with Freebayes "
        echo " You need to specify where the reference  file are located to run this script"
        echo " The reference is a fasta file"
        echo " the reference file for my mac is "~/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa"
        echo " the reference file for the linux is "/data/Megan/IPO323/Mycosphaerella_graminicola.allmasked.fa"
        exit 1
    else
    OPTIONS="-p 1 -i -u -n 10000 -0 --no-partial-observations"
    REFFILE=$1
    BAMPATH=/Users/meganm/Genomes/GATK_Variant_Detection
    ## execute freebayes
    ls $BAMPATH/WAI320.realign.bam
    freebayes $OPTIONS -v Top10Ksnps.vcf -f Mycosphaerella_graminicola.unmasked.fa -L REalignBAMlist.txt
fi