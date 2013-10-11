#!/usr/bin/env python

#  Get_expression_profile.py
#  
#
#  Created by Megan McDonald on 5/02/13.
#


InFileName = 'secreted_proteins.txt' ## this script is formated to go with this text file 'secreted_proteins.txt'
InFile = open(InFileName, 'r')
EarlyOutName = InFileName + "EARLY_OUT" + ".txt"
EarlyOut = open(EarlyOutName, 'w')
LateOutName = InFileName + "LATE_OUT" + ".txt"
LateOut = open(LateOutName, 'w')


LineNumber =0


for Line in InFile:
    if LineNumber==0:
        Line = Line.strip('\n') # stripping the line end character off of my strings
        ElementList = Line.split('\t')  # parsing the tab file into its smaller parts making each line into a list
        header= '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s' %(ElementList[0],ElementList[2],ElementList[4],ElementList[5],ElementList[6],ElementList[13],ElementList[14],ElementList[15])##str(ElementList[0:])
        EarlyOut.write(header+"\n")
        LateOut.write(header+"\n")
    elif LineNumber >0:  #skipping the header line
        Line = Line.strip('\n') # stripping the line end character off of my strings
        ElementList = Line.split('\t')  # parsing the tab file into its smaller parts making each line into a list
        if float(ElementList[13])>1000 and float(ElementList[13])>float(ElementList[14])>float(ElementList[15]):
            OutputString = '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s' %(ElementList[0],ElementList[2],ElementList[4],ElementList[5],ElementList[6],ElementList[13],ElementList[14],ElementList[15])
            EarlyOut.write(OutputString+ "\n")
        elif float(ElementList[15])>500 and float(ElementList[13])<=float(ElementList[14])<=float(ElementList[15]):
            OutputString = '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s' %(ElementList[0],ElementList[2],ElementList[4],ElementList[5],ElementList[6],ElementList[13],ElementList[14],ElementList[15])
            LateOut.write(OutputString+"\n")
    LineNumber = LineNumber +1


InFile.close()
EarlyOut.close()
LateOut.close()