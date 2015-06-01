#!/usr/bin/env python
import csv
import sys
from Bio import SeqIO
from Bio.Seq import Seq

## There are four arguments needed 1) species name  2) the de novo assembly for that species 3) the fasta file containing the BLAST queries 4) the output from BLAST
inputfasta=sys.argv[1]
outputname=sys.argv[2]





# this is an output file that integrates the isolate name species
gff_file= open(outputname+".gff", 'w')

for seq_record in SeqIO.parse(inputfasta, "fasta"):
    name=seq_record.id
    source="MIPS"
    feature="transcript"
    length=len(seq_record)
    start=1
    score="."
    strand="+"
    frame=1
    attribute="gene_id:"+name
    gff_line= "%s\t%s\t%s\t%d\t%d\t%s\t%s\t%d\t%s" % (name, source,feature, start, length, score, strand, frame, attribute)
    gff_file.write(gff_line+"\n")


gff_file.close()


