#! /usr/bin/env python

## Set input file
## Hard Coded use line below
##InFileName = "StartPos_genes.csv_OUT.txt"

import sys

USAGE= """Take a csv file and convert it into a file ready to use with BLASTdbcmd, file will contain the name and start stop coordinates for Seqences extraction from a DNA database
Range_reverse.py inputfile.csv"""

if len(sys.argv)<2:
    print Usage

else:
    InFileName = sys.argv[1]
    InFile = open(InFileName, 'r')
    OutFileNameFor = InFileName + "FOR_OUT" + ".txt"
    OutFileNameRev = InFileName + "REV_OUT" + ".txt"
    OutFileFor = open(OutFileNameFor, 'w')
    OutFileRev = open(OutFileNameRev, 'w')

LineNumber =0

"""Get the csv file generated in Get_UTRscript.py and reverse the - strand positions so they go from lower to higher numbers"""

for Line in InFile:
    Line = Line.strip('\n')
    ElementList = Line.split('\t')
    if int(ElementList[4])==0:
        OutputStringFor = "-entry scaffold_%s -range %s-%s" % (ElementList[1], ElementList[2], ElementList[3])
        OutFileFor.write(OutputStringFor+"\n")
    elif int(ElementList[4])==1:
        OutputStringRev = "-entry scaffold_%s -range %s-%s" % (ElementList[1], ElementList[3], ElementList[2])
        OutFileRev.write(OutputStringRev+"\n")

InFile.close()
OutFileFor.close()
OutFileRev.close()

