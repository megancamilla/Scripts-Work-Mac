#!/usr/bin/env python
import csv
import sys
from Bio import SeqIO
from Bio.Seq import Seq
species='ST56'




denovo={}

for seq_record in SeqIO.parse("/Volumes/Solomon_Lab/Megan/Spades_assembly/Complete_genomes/"+species+".spades.fa", "fasta"):
    denovo[seq_record.id]=str(seq_record.seq)

refgene={}

for seq_record in SeqIO.parse("/Users/meganm/Genomes/IPO323/Gffs_ensemble/Ztritici_gdna.fa", "fasta"):
    refgene[seq_record.id]=str(seq_record.seq)

gff_file= open(species+".spades.refgene.gff", 'w')

fasta_file=open(species+".spades.refgene.fasta",'w')

f = open("/Volumes/Solomon_Lab/Megan/Spades_assembly/STblast/"+species+".blastn.out", 'rt')
reader = csv.reader(f,dialect='excel-tab')
oldquery=''
for row in reader:
    query=row[0]
    subject=row[1]
    qstart=int(row[4])
    qend=int(row[5])
    sstart=int(row[7])
    send=int(row[8])
    if str(oldquery)==str(query):
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
        seq_denovo= Seq(denovo[subject][sstart:send+1])
        seq_denovo=seq_denovo.reverse_complement()
        str_seq_denovo=str(seq_denovo)
        gff_file.write(gff_line+"\n")
        fasta_file.write(fasta_name+"\n")
        fasta_file.write(str_seq_denovo+"\n")
    oldquery=query

gff_file.close()
fasta_file.close()

