cd#!/bin/sh

#  Lastz_alignment.sh
#  
#
#  Created by Megan McDonald on 21/01/14.
# Shell script for pairwise alignment of Spades assembled genomes to IPO323 and # to Zt79.1.1a

ISOLATES=`cat $1`
for line in $ISOLATES
do
lastz /Users/meganm/Genomes/IPO323/Mycosphaerella_graminiocola.allmasked.fa \
/Volumes/Solomon_Lab/Megan/Spades_assembly/Complete_genomes/$line.spades.fa \
 --yasra95 --output=$line.lastz.sam --strand=both --format=sam --rdotplot=$line_dot --ambiguous=n --chain --maxwordcount=90% --gapped \
 --identity=75 -inner=1000
done
