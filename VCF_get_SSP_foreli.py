#!/usr/bin/env python

## Python script to loop through a list of protein names
## Goal is to pull out all lines that contain the name of the protein
## This file should contain any SNPs that occur between the reference and the resequenced genomes in the given genes

import re
# import the list of protein names
# file used for this script contains the name in column 2 of a tab delimited file

#InFilePATH = 'Cysteine_richSSP.delim'
#VCFpath= '/Users/meganm/Genomes/GATK_Variant_Detection/Ztritici.GATK.snpeff.vcf'
InFilePATH = '/Users/meganm/Desktop/search.txt'
VCFpath= '/Users/meganm/Desktop/tosearch.txt'
INFILE = open(InFilePATH, 'r')
VCFfile = open(VCFpath, 'r')
OUTFILE = open('test.out', 'w')
##
OUTFILE2=open('Elis_otherfile', 'w')

# create an empty list into which to place the protein names found in column 2 of the file



Protein_list=[]
# for each line strip off the line end character
for line in INFILE:
    line = line.strip()
    field = line.split('\t')
    protein = field[0]
    for LINE in VCFfile:
    field2= line.split('\t')
    protein = field[
    if protein=
        OUTFILE.write(line)


INFILE.close()
OUTFILE.close()
OUTFILE2.close()


