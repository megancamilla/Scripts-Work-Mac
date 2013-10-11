#!/usr/bin/env python

## Script to convert the Mgraminicola_frozen_genecatalog.gff to a proper gff3 file
## Goal is to achieve a file that looks like a gff3 file from ENSEMBL
# Chromosome    Source  Feature    StartPos    Stop Pos    .    Strand
# chr_1    protein_coding  gene  354    654    .    +    .    ID=gene:Ztr_001;Name="fgnesh_001";Note=Predicted, no EST support
# chr_1    protein_coding  mrna  360    651    .    +    .    ID=transcript:

import sys
import re

USAGE= """Script to convert the Mgraminicola Frozen gene catalog into a proper gff3 file"""
print USAGE
##if len(sys.argv)<2:
##print USAGE

##else:
##InFileName = sys.argv[1]
InFileName = 'Mgraminicolav2-3.FilteredModels1.gff'
InFile = open(InFileName, 'r')
OutFileName = InFileName + ".gff3"
OutFile = open(OutFileName, 'w')

## function to pull out all of the start codon pos and put that in a dictionary with the name of the gene as a key
def get_start_pos_dict(InFileName):
    handle = open(InFileName)
    startpos = {}
    # for look at each line and strip of the line end character
    for line in handle:
        line = line.strip()
        if not "start_codon" in line:
            continue
        field = line.split('\t')
        genesearch = '(name) "(.+)"'
        genename = re.search(line, genesearch)
        # assign a value to the start codon
        if field[6]== '+':
            pos = field[3]
        elif field[6] == '-':
            pos = field[4]
        startpos[genename]= (pos)
    handle.close()
    return startpos


## function to pull out all of the start codon pos and put that in a dictionary with the name of the gene as a key
def get_stop_pos_dict(InFileName):
    handle2 = open(InFileName)
    stoppos = {}
    # for look at each line and strip of the line end character
    for line in handle2:
        line = line.strip()
        if not "stop_codon" in line:
            continue
        field2 = line.split('\t')
        genesearch = '(name) "(.+)"'
        genename = re.search(line, genesearch)
        # assign a value to the stop codon
        if field2[6]== '+':
            pos = field2[4]
        elif field2[6]== '-':
            pos = field2[3]
        # write the dictionary with the key:name and the two values for start and stop
        stoppos[genename] = (pos)
    handle2.close()
    return stoppos


"""Read in the current gff file, and group the lines that contain the same name into a temporary file"""
for line in InFile:
    line = line.strip()
    # If there is an empty line keep going
    fields = line.split('\t')
    # make dictionaries
    get_start_pos_dict(InFileName)
    chromosome = fields[0]
    source = fields[1]
    type = fields[2]
    positionstart = fields[3]
    positionstop = fields[4]
    dot1 = fields[5]
    strand = fields[6]
    dot2 = fields[7]
    if type == "start_codon":
        namesearch = '(name) "(.+)"'
        Result = re.search(namesearch, line)
        name = Result.group(2)
        newline = "%s\tprotein_coding\tmRNA\t%s\t%s\t%s\t%s\t%s\tID=transcript:%s;Parent=gene:%s" % (chromosome, positionstart, positionstop, dot1, strand, dot2, name, name) 
        OutFile.write(newline+"\n")
    elif type == "exon":
        exonsearch = '(name) "(.+)"\; transcriptId (\d+)'
        Result = re.search(exonsearch, line)
        name = Result.group(2)
        transcriptID = Result.group(3)
        newline = "%s\tprotein_coding\t%s\t%s\t%s\t%s\t%s\t%s\tID=exon:%s;Parent=gene:%s" % (chromosome, type, positionstart, positionstop, dot1, strand, dot2, transcriptID, name)
        OutFile.write(newline+"\n")
    elif type == "CDS":
        cdssearch = '(name) "(.+)"\; proteinId (\d+); exonNumber (\d+)'
        Result = re.search(cdssearch, line)
        name = Result.group(2)
        transcriptID = Result.group(3)
        exonnumber = Result.group(4)
        newline = "%s\tprotein_coding\t%s\t%s\t%s\t%s\t%s\t%s\tID=cds:%s.%s;Parent=gene:%s" % (chromosome, type, positionstart, positionstop, dot1, strand, dot2, transcriptID, exonnumber, name)
        OutFile.write(newline+"\n")

InFile.close()
OutFile.close()

