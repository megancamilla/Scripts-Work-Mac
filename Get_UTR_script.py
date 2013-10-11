#! /usr/bin/env python

## Set input file

#InFileName = "StartPos_genes.csv"
#InFile = open(InFileName, 'r') hard code
### Hard coded version use the lines above and comment out the if else statements

USAGE = """ Get the 1000 bp upstream of the start codon, taking into consideration the orientation of the gene
INPUT = Get_UTR_script.py textfile.csv"""

import sys

if len(sys.argv)<2:
    print Usage

else:
    InFileName = sys.argv[1]
    InFile = open(InFileName, 'r')
    OutFileName = InFileName + "_OUT" + ".txt"
    OutFile = open(OutFileName, 'w')

LineNumber =0
""" Generate loop that skips the first line (header of the file) strips of the un-needed
line ending characters and then adds or substracts 1000 bp to the start position of the
gene, taking into account the orientation of the startcodon. Records the new value in a column that
is written to a file. The two files are then merged to create a new file with both the 
start and stop of the UTR region"""

for Line in InFile:
	if LineNumber >0:  #skipping the header line
		Line = Line.strip('\n') # stripping the line end character off of my strings
		ElementList = Line.split(',')  # parsing the csv file into its smaller parts making each line into a list
		if int(ElementList[4])==0:
			X= int(ElementList[2])-1000
		elif int(ElementList[4])==1:
			X= int(ElementList[2])+1000
		OutputString = "%s,%s,%s,%s,%s" % (ElementList[1],int(ElementList[0]),X, int(ElementList[2]), int(ElementList[4]))
		OutFile.write(OutputString+"\n")
	LineNumber = LineNumber +1


InFile.close()
OutFile.close()