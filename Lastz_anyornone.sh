#!/bin/bash

#  Lastz_anyornone.sh
#  
#
#  Created by Megan McDonald on 11/11/2014.
#
reference=/Users/meganm/Genomes/IPO323/IPO323_merged_chromosomes.fa
ISOLATES=`cat $1`
for line in $ISOLATES
do
echo "------------------"$line"-----Start----------------------------"
lastz $reference /Volumes/Solomon_Lab/Megan/Spades_assembly/Complete_genomes/$line.spades.fa --anyornone \
--step=10 --seed=match12 --notransition --exact=20  \
--coverage=90 --identity=95 --format=general:name2 --output=$line.aligned.contigs
done
