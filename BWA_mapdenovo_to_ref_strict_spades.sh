#!/bin/bash

# Shell script to align the de novo Spades assembly to the reference IPO323

### show usage if we don't give at least 2 command-line arguments when we call the script ###
ISOLATES=$1
if [ "$1" == "" ]
    then
    echo "-----------------------------------------------------------------";
    echo "Align your Velvet denovo assembly to the IPO323 reference genome";
    echo "Current script is strict to prevent contigs from mapping to more than one place";
    echo "USAGE";
    echo "VelvetCheck.sh IsolateNAME";
    echo "example usage:";
    echo " VelvetCheck.sh 320";
    echo "-----------------------------------------------------------------";
    exit 1;
    else
    REFPATH=/Users/meganm/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa
    ISOLATENAME=`cat $ISOLATES`
    for line in $ISOLATENAME
        do
         INPATH="/Volumes/Solomon_Lab/Megan/Spades_assembly/Complete_genomes/"$line".spades.fa"
         #echo "---------Generating reference index file -----------------------------------"
         #bwa index -p IPO323 $REFPATH
         echo "---------Assembling "$line" Spades de novo assembly to IPO323 --------------------";
         bwa mem -M $REFPATH $INPATH > ""$line"_SPADES_denovo_bwamem.sam"
         echo "---------DONE Assembling "$line" SPAdes de novo assembly to IPO323 --------------------";
done
fi
