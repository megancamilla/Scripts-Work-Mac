#!/bin/bash

#  Lastz_alignment.sh
#  
#
#  Created by Megan McDonald on 21/01/14.
# Shell script for pairwise alignment of Spades assembled genomes to IPO323 and # to Zt79.1.1a

ISOLATES=`cat $1`
for line in $ISOLATES
do
lastz /Users/meganm/Genomes/IPO323/IPO323_merged_chromosomes.fa /Volumes/Solomon_Lab/Megan/Spades_assembly/Complete_genomes/$line.spades.fa \
 --yasra98 --output=$line.lastz.90.sam --strand=both --format=sam  --ambiguous=n --chain  --gapped --identity=90 --inner=1000
done
