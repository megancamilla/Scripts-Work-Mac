#!/bin/bash

ISOLATES='/Users/meganm/Genomes/GATK_Variant_Detection/isolatenames.txt'
ISOLATELINE=`cat $ISOLATES`

for line in $ISOLATELINE
    do
    echo start $line
    grep \> $line.delly_q30_c5.del.txt > $line.delly.summary.txt
    done
