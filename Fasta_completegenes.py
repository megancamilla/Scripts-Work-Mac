#!/usr/bin/env python


## Script to look through files generated by augustus and parse out the gene name, length, whether or not it has start and stop codons
##Read in multiple fasta file and examine if start stop codons are present, report the length of the gene in nuc
import sys
from Bio import SeqIO
from Bio.Alphabet import IUPAC
from Bio.Data import CodonTable

standard_table = CodonTable.unambiguous_dna_by_id[1]
#fastapath = "/Volumes/My Network Data$/u5261870/Augustus_training_data/UNMAPPED_denovo_contigs_MASKED/augustus/augustus.codingseq"
fastapath = sys.argv[1]
fastafile=open(fastapath, 'rU')
input_seq_iterator = SeqIO.parse(fastafile, "fasta")

for record in input_seq_iterator:
#    print record.seq[0:3]
    print record.name, str(len(record.seq))


startstopcodon_iterator = (record for record in input_seq_iterator if str(record.seq[0:3])=='atg' and (str(record.seq[-3:])=='tag' or str(record.seq[-3:])=='taa' or str(record.seq[-3:])=='tga'))

output_handle = open("Complete_genes_abinitio.fa", "w")
SeqIO.write(startstopcodon_iterator, output_handle, "fasta")
output_handle.close()
