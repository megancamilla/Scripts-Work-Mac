#!/bin/bash

## Shell script to loop through realigned files with GenomeCoverageBed from bedtools
## goal is to create a file to detect coverage drops in the alignment

ISOLATES='isolatenames.txt'
ISOLATELINE=`cat $ISOLATES`
for line in $ISOLATELINE
    do
    echo START $line
    genomeCoverageBed -bga  -ibam ""$line"".realign.bam -g CoveragePlots/Ztritici_bedtools.genome > CoveragePlots/""$line"".genomecovBed.bedgraph
    echo Finished with $line
    done
fi

