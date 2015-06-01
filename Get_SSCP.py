#!/usr/bin/env python

#  Get_SSCP.py
#  
#
#  Created by Megan McDonald on 23/08/13.
#
## Python script to loop through a list of protein names
## Goal is to pull out all lines that contain the name of the protein
## This file should contain any SNPs that occur between the reference and the resequenced genomes in the given genes

import re
import sys
# import the list of protein names
# file used for this script contains the name in column 2 of a tab delimited file

#InFilePATH = 'Cysteine_richSSP.delim'
#VCFpath= '/Users/meganm/Genomes/GATK_Variant_Detection/Ztritici.GATK.snpeff.vcf'
InFilePATH=sys.argv[1]
VCFpath=sys.argv[2]
outname=sys.argv[3]
#InFilePATH = '/Users/meganm/Dropbox/Megans_Data/Zymoseptoria_tritici/Cysteine_rich_250aaLESS.delim'
#VCFpath= '/Users/meganm/Genomes/GATK_Variant_Detection/trial.vcf'
INFILE = open(InFilePATH, 'r')
VCFfile = open(VCFpath, 'r')
OUTFILE = open(outname, 'w')

# create an empty list into which to place the protein names found in column 2 of the file



Protein_list=[]
# for each line strip off the line end character
for line in INFILE:
    line = line.strip()
    field = line.split('\t')
    protein = field[0]
    Protein_list.append(protein)
    pattern=re.compile('|'.join(Protein_list))

for line in VCFfile:
    if pattern.search(line):
        OUTFILE.write(line)


INFILE.close()
OUTFILE.close()
