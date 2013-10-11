#!/bin/sh

### Shell script to loop through all the bed file and pull out regions with zero coverage
### Exclude regions that occur within the last 5% of the chromosome length on both ends
### A nice added feature would be to not just pull out zero coverage but look at regions\
### that have a sharp drop in coverage within 50 bp of the zero coverage area.
### Then overlap those regions with the gene.bed file for IPO323 and see which genes have 0 coverage

# Get Unique isolate names for the loop
ISOLATES='/Users/meganm/Genomes/GATK_Variant_Detection/isolatenames.txt'
ISOLATENAME=`cat $ISOLATES`

for line in $ISOLATENAME
    do
    echo "grabbing 0 coverage for "$line""
    grep -w 0$ $line.genomecovBed.bedgraph > $line.zeroCOV.bed
done

#!/usr/bin/env python

import re

InFileNAME= sys.argv[1]
InFILE= open(InFileNAme, 'r')
OutFileName = InFileName + "biginterval.bed"
OutFile = open(OutFileName, 'w')

for line in InFILE:
    line = line.strip('\n')
    ElementList = line.split('\t')
    DEL = int(ElementList[2])-int(ElementList[1])
    for DEL > 50:
        OutputString= "%s\t%s\t%s\t%s" % (ElementList[0], ElementList[1], ElementList[2], ElementList[3])
        OutFile.write(OutputString + "\n")

InFILE.close()
OutFile.close()

