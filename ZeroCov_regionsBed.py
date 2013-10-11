#!/usr/bin/env python

import sys
import re

InFileNAME= sys.argv[1]
InFILE= open(InFileNAME, 'r')
OutFileName = InFileNAME + "biginterval.bed"
OutFile = open(OutFileName, 'w')

for line in InFILE:
    line = line.strip('\n')
    ElementList = line.split('\t')
    DEL = int(ElementList[2])-int(ElementList[1])
    if DEL>250:
        OutputString= "%s\t%s\t%s\t%s" % (ElementList[0], ElementList[1], ElementList[2], ElementList[3])
        OutFile.write(OutputString + "\n")

InFILE.close()
OutFile.close()

