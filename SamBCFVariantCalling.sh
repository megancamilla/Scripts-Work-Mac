#!/bin/sh

#  SamBCFVariantCalling.sh
#  
#
#  Created by Megan McDonald on 10/04/13.
#
## Basic script using samtools and bcftools to generate BCF (binary version of a VCFfile) using ##both samtools and bcftools

INREFGENOME=$1
INBAMFILE=$2
OUTPREFIX=$3

#### Usage statement #######
if [ "$OUTPREFIX" == "" ]; then
    echo "-----------------------------------------------------------------";
    echo "Generate a binary Variant file with samtools and make legible with bcftools";
    echo " USAGE:";
    echo "SamBCFVariantCalling.sh INREFGENOME INBAMFILE OUTPREFIX";
    echo " ";
    echo "  INREFGENOME   path to Fasta formatted Reference genome";
    echo "  INBAMFILE   path to sorted bam file aligned to Ref genome";
    echo "  OUTPREFIX   Desired name of output file";
    echo "Example:";
    echo "BowtietoIGV.sh Ztritici.fasta Isolate.sorted.bam";
    echo "----------------------------------------------------------------";
    exit 1;
fi

echo "----------------------------------------------";
echo "###### Use mpileup to calculate variants ######";
echo "----------------------------------------------";

samtools mpileup -u -f $INREFGENOME $INBAMFILE > $OUTPREFIX.bcf;

echo "----------------------------------------------";
echo "###### Finsihed making bcf file ######";
echo "----------------------------------------------";

echo "----------------------------------------------";
echo "###### Start makeing VCF file ######";
echo "----------------------------------------------";


bcftools view -v -c -g $OUTPREFIX.bcf > $OUTPREFIX.vcf;

echo "----------------------------------------------";
echo "###### DONE makeing VCF file ######";
echo "----------------------------------------------";