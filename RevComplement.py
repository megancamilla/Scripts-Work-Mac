#!/usr/bin/env python

#  RevComplement.py
#  
#
#  Created by Megan McDonald on 23/01/13.
#
import sys
import cogent



Usage="""RevComplement python script - version1.0 import a FASTA file of 
sequences and reverse complement each sequence Usage: RevComp.sh input.fasta
> revcomp.fasta"""


### expects a fasta file name as the argument
if len(sys.argv)<2:
    print Usage

else:
    InfileName= sys.argv[1]
    Infile= open(InfileName, 'r')
    RecordNum= -1
    OutFileName = InfileName + "_RevComp.txt"
    OutFile = open(OutFileName,'w')

##Setup a blank list and blank dictionary for the input of names and sequences
Sequences= []
SeqDict= {}

for Line in Infile:
    Line= Line.strip('\n')
    if Line[0] =='>':
        Name=Line[1:]
        Sequences.append([Name,''])
        RecordNum += 1
#make a two-item list with the name as the first element,
# and the empty string as the second
# Use the Name for the Dictionary key
        SeqKey = Name
        SeqDict[SeqKey] =''
    elif RecordNum > -1:
        Sequences[RecordNum][1] += Line
        SeqDict[SeqKey] += Line

##Convert strings in List Sequences into DNA objects with cogen.makeSequence
## Use cogent to reverse complement and then write out new FASTA file
from cogent import DNA
for Seq in Sequences:
    my_seq = DNA.makeSequence(Seq[1])
    rc_seq = my_seq.reversecomplement()
    seqname = Seq[0]
    outstring = ">%s\n%s" % (seqname,rc_seq)
    OutFile.write(outstring +'\n')


Infile.close()
OutFile.close()