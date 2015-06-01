#!/usr/bin/env python
import csv
import sys
from Bio import SeqIO
from Bio.Seq import Seq

## There are four arguments needed 1) species name  2) the de novo assembly for that species 3) the fasta file containing the BLAST queries 4) the output from BLAST
species=sys.argv[1]






denovo={}

for seq_record in SeqIO.parse("/home/meganm/Spades_denovo/"+species+".spades.fa", "fasta"):
    denovo[seq_record.id]=str(seq_record.seq)

refgene={}

## This is the reference gDNA file that you used for the BLAST queries
for seq_record in SeqIO.parse("/home/meganm/genomealignments/reference/Ztritici_gdna.fa", "fasta"):
    refgene[seq_record.id]=str(seq_record.seq)
# this is an output file that integrates the isolate name species
gff_file= open("/home/meganm/genomealignments/spadesblast/newgffs_50/"+species+".spades.refgene.gff", 'w')
# this is the second output file which integrates the name species
fasta_file=open("/home/meganm/genomealignments/spadesblast/newgffs_50/"+species+".spades.refgene.fasta",'w')
# Need to specify where the BLAST output file is
f = open("/home/meganm/genomealignments/spadesblast/"+species+".blastn.out", 'rt')
reader = csv.reader(f,dialect='excel-tab')
oldquery=''
for row in reader:
    query=row[0]
    subject=row[1]
    querylen=row[4]
    alignlen=row[3]
    qstart=int(row[5])
    qend=int(row[6])
    sstart=int(row[8])
    send=int(row[9])
    if str(oldquery)==str(query):
        continue
    if int(alignlen)/int(querylen)<=.5:
        continue
    elif sstart<=send:
        gff_line= "%s\t%s\t%d\t%d" % (subject, query, sstart, send)
        fasta_name= ">%s__%s" % (query,subject)
        seq_denovo= "%s" %(denovo[subject][sstart:send+1])
        gff_file.write(gff_line+"\n")
        fasta_file.write(fasta_name+"\n")
        fasta_file.write(seq_denovo+"\n")
    elif sstart>=send:
        gff_line= "%s\t%s\t%d\t%d" % (subject, query, send, sstart)
        fasta_name= ">%s__%s" % (query,subject)
        seq_denovo= Seq(denovo[subject][send:sstart+1])
        seq_denovo=seq_denovo.reverse_complement()
        str_seq_denovo=str(seq_denovo)
        gff_file.write(gff_line+"\n")
        fasta_file.write(fasta_name+"\n")
        fasta_file.write(str_seq_denovo+"\n")
    oldquery=query

gff_file.close()
fasta_file.close()

