#! /usr/bin/env python

import sys

USAGE= """Re-format your files WAI###.delly.summary.txt into Bed6 format. Columns in new file are as follows:
Chromosome	Start	Stop	Name	#Paried ends	Strand"""
## set Input file name

if len(sys.argv)<1:
    print USAGE
else:
    InFileNAME= sys.argv[1]
    InFILE = open(InFileNAME, 'r')
    OutFileName = InFileNAME + "BED6.bed"
    OutFile = open(OutFileName, 'w')
    
for Line in InFILE:
    Line = Line.strip('\n')
    ElementList = Line.split('\t')
    Name = str(ElementList[6])
    subNAME = Name[1:25]
    OutputString= "%s\t%s\t%s\t%s\t%s\t+" % (ElementList[0],ElementList[1],ElementList[2],subNAME,ElementList[4])
    OutFile.write(OutputString + "\n")

InFILE.close()
OutFile.close()
