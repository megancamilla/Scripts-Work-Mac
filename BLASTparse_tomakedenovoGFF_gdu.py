#!/usr/bin/env python
import csv
import sys
from Bio import SeqIO
species='WAI320'




denovo={}

for seq_record in SeqIO.parse("/home/meganm/Spades_denovo/"+species+".spades.fa", "fasta"):
    denovo[seq_record.id]=str(seq_record.seq)

refgene={}

for seq_record in SeqIO.parse("/home/meganm/genomealignments/reference/Ztritici_gdna.fa", "fasta"):
    refgene[seq_record.id]=str(seq_record.seq)

gff_file= open(species+".spades.refgene.gff", 'w')

fasta_file=open(species+".spades.refgene.fasta",'w')

f = open("/home/meganm/genomealignments/spadesblast/"+species+"blastn.out", 'rt')
reader = csv.reader(f,dialect='excel-tab')
oldquery=''
for row in reader:
    if row[0]=='':
        break
    else:
    query=row[0]
    subject=row[1]
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
        seq_denovo= "%s" %(denovo[subject][send:sstart+1])
        gff_file.write(gff_line+"\n")
        fasta_file.write(fasta_name+"\n")
        fasta_file.write(seq_denovo+"\n")
    oldquery=query

gff_file.close()
fasta_file.close()

