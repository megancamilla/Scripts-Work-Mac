#!/usr/bin/env python
import csv
import sys
from Bio import SeqIO
from Bio.Seq import Seq
species='WAI320'




denovo={}

for seq_record in SeqIO.parse("/Volumes/Solomon_Lab/Megan/Spades_assembly/Complete_genomes/WAI320.spades.fa", "fasta"):
    denovo[seq_record.id]=str(seq_record.seq)

refgene={}

for seq_record in SeqIO.parse("/Users/meganm/Genomes/IPO323/Gffs_ensemble/Ztritici_gdna.fa", "fasta"):
    refgene[seq_record.id]=str(seq_record.seq)

gff_file= open(species+".spades.refgene.gff", 'w')

fasta_file=open(species+".spades.refgene.fasta",'w')

f = open("/Users/meganm/Desktop/test."+species+".gdna.blast", 'rt')
reader = csv.reader(f,dialect='excel-tab')
oldquery=''
for row in reader:
    query=row[1]
    subject=row[0]
    qstart=int(row[5])
    qend=int(row[6])
    sstart=int(row[8])
    send=int(row[9])
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

