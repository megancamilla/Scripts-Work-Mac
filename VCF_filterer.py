#!/usr/bin/env python
#Python 2.7.5 
#Requires biopython

############### BLASTtoGFF_50percent.py ##################

# Takes VCF file and filters out lines based on whether or not the protein is secreted, small or cysteine rich
# Requires a reference genome protein fasta file and list of names of secreted proteins
# 

#Version 1. Megan McDonald, April 2015.
#Contact Megan McDonald, megan.mcdonald@anu.edu.au

###Import modules
import os
import csv
import sys
import argparse
import re
from Bio import SeqIO
from Bio.Seq import Seq
from os.path import basename


def main(inVCF=None, refFasta=None, SecretedList=None, outVCF=None, maxGeneSize=250, Cysteine=0.05):
	
	# open VCF file to be filtered
	vcf=open(inVCF, 'r')
	#open secreted protein list
	prot=open(SecretedList,'r')
	# This is an output file that integrates the isolate name species
	OUTFILE= open(outVCF, 'w')
	
	
	refgene={}
	
	for seq_record in SeqIO.parse(refFasta, "fasta"):
		refgene[seq_record.id]=[str(seq_record.seq),len(seq_record.seq),(float(seq_record.seq.count("C"))/float(len(seq_record.seq)))]
	
	MGS=maxGeneSize
	CYS=Cysteine
	Protein_list=['#']
	# for each line strip off the line end character
	for line in prot:
		line = line.strip()
		field = line.split('\t')
		protein = field[0]
		if refgene[protein][1] <=int(MGS) and refgene[protein][2] >=float(CYS):
			print protein
			print "%d\t%f\r" % (refgene[protein][1],refgene[protein][2])
			Protein_list.append(protein)
			pattern=re.compile('|'.join(Protein_list))
	
	
	
	for line in vcf:
		if pattern.search(line):
			OUTFILE.write(line)
	
	
	
	OUTFILE.close()
	prot.close()
	vcf.close()
	
if __name__== '__main__':
	###Argument handling.
	arg_parser = argparse.ArgumentParser(
		description="Takes a list of secreted proteins (1 column format) and a reference protein dataset \
		and extracts from an annotated VCF the lines (SNPS) that occur in genes in the given list.\
		Will also take into account length and cysteine content of the reference protein")
	arg_parser.add_argument("-i","--inVCF", default=None, required=True, help="Path to SnpEff VCF file to be filtered, required")
	arg_parser.add_argument("-r","--refFasta", default=None, required=True, help="Path to protein fasta file containing genes annotated in SnpEff VCF file, required")
	arg_parser.add_argument("-s","--SecretedList", default=None, required=True, help="List of Secreted protien names one column, required")
	arg_parser.add_argument("-o","--outVCF", default=None, required=True, help="Path to VCF output file, required")
	arg_parser.add_argument("-g","--maxGeneSize", default=250, type=int, help="Max length of gene to be considered, default 250 amino acids, set to length of longest gene if you want no filter")
	arg_parser.add_argument("-y","--Cysteine", default=0.05, type=float, help="Min cysteine percentage to be considered, default 0.05, set to 0 if you don't want to filter by cysteine content")
	
	if len(sys.argv)==1:
		arg_parser.print_help()
		sys.exit(1)
	
	#Parse arguements
	args = arg_parser.parse_args()
	
	###Variable Definitions
	inVCF=args.inVCF
	refFasta=args.refFasta
	SecretedList=args.SecretedList
	outVCF=args.outVCF
	maxGeneSize=args.maxGeneSize
	Cysteine=args.Cysteine
	
	main(inVCF, refFasta, SecretedList, outVCF, maxGeneSize, Cysteine)