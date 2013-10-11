#!/usr/bin/env python
"""User script to calculate the proportion of Cysteines in a FASTA file list of protiens"""
import sys
from Bio import SeqIO
from Bio.Alphabet import IUPAC

#fastapath = 'Ztritici_250LESS_signalP.fa'
fastapath = 'Ztritici_250aaLESS.fa'

input_seq_iterator = SeqIO.parse(open(fastapath, 'rU'), "fasta")
cystein_rich_iterator = (record for record in input_seq_iterator if ((float(record.seq.count("C"))/float(len(record.seq))) > 0.05))

output_handle = open("Cysteine_rich_250aaLESS.fa", "w")
SeqIO.write(cystein_rich_iterator, output_handle, "fasta")
output_handle.close()
