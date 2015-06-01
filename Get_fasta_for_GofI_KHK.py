#!/bin/sh

#  Get_fasta_for_GofI.py
#  
#
#  Created by Megan McDonald on 8/07/2014.
#
import sys

from Bio import SeqIO

#USAGE="""Reduce a large fasta file by providing a list of gene names needed. Input is the fasta files for the whole genome and the gene list. Output is a multi-isolate fasta file for each gene
#First argument is list of genes, all other arguments are fasta files"""

#if len(sys.argv)<2:
#    print USAGE
#else:
#    Gene_list=sys.argv[0]
#    Fasta_list=sys.argv[1:]
Gene_list_name="/Volumes/Solomon_Lab/Megan/Spades_assembly/gdnablast_50percent/Secretome_KHK/KHK_492secretome.txt"
Gene_list=open(Gene_list_name, 'rU')



Namelist=['WAI320','WAI321','WAI322','WAI323','WAI324','WAI326','WAI327','WAI328','WAI329']
#Import reference genome annotation
refgene={}
for seq_record in SeqIO.parse("/Users/meganm/Genomes/IPO323/Gffs_ensemble/Ztritici_gdna.fa", "fasta"):
    refgene[seq_record.id]=["IPO323",str(seq_record.seq)]
    for name in Namelist:
        FA=[name, str("")]
        refgene[seq_record.id].append(FA)

#Make loop for Spades assembly Blastn generated fastas...fastas were created by blasting the reference gdna against the spades de novo assemblies
#Add each isolates gene sequence to the Reference dictionary

x=2
for name in Namelist:
    for seq_record2 in SeqIO.parse("/Volumes/Solomon_Lab/Megan/Spades_assembly/gdnablast_50percent/"+name+".spades.short.fasta", "fasta"):
        bases=str(seq_record2.seq)
        refgene[seq_record2.id][x][1]=bases
    x=x+1


##Extract genes of interest and write to fasta file for each gene.

##Need to add in function that ignores empty values . . .or need to create the dictionary so that it includes blanks where the gene does not exist

for line in refgene:
    fs=open("/Volumes/Solomon_Lab/Megan/Spades_assembly/gdnablast_50percent/genomefastas/"+line+".fasta", 'w')
    IPOline=">IPO323-%s\n%s\n" % (line, refgene[line][1])
    WAI320line=">WAI320-%s\n%s\n" % (line, refgene[line][2][1])
    WAI321line=">WAI321-%s\n%s\n" % (line, refgene[line][3][1])
    WAI322line=">WAI322-%s\n%s\n" % (line, refgene[line][4][1])
    WAI323line=">WAI323-%s\n%s\n" % (line, refgene[line][5][1])
    WAI324line=">WAI324-%s\n%s\n" % (line, refgene[line][6][1])
    WAI326line=">WAI326-%s\n%s\n" % (line, refgene[line][7][1])
    WAI327line=">WAI327-%s\n%s\n" % (line, refgene[line][8][1])
    WAI328line=">WAI328-%s\n%s\n" % (line, refgene[line][9][1])
    WAI329line=">WAI329-%s\n%s\n" % (line, refgene[line][10][1])
    fs.write(IPOline+WAI320line+WAI321line+WAI322line+WAI323line+WAI324line+WAI326line+WAI327line+WAI328line+WAI329line)
    fs.close()

#    Zt79line=">Zt79-%s\n%s\n" % (line, refgene[line][11][1]) need to put back in line below if you use Zt79

####Filter out fasta files for too short or empty sequences

for key in refgene:
    missing_genes=[]
    good_genes=[]
    for record in SeqIO.parse("/Volumes/Solomon_Lab/Megan/Spades_assembly/gdnablast_50percent/genomefastas/"+key+".fasta", "fasta"):
        if len(record.seq) < 10:
            missing_genes.append(record)
        else:
            good_genes.append(record)
        output1=open("/Volumes/Solomon_Lab/Megan/Spades_assembly/gdnablast_50percent/genomefastas/"+key+".fasta", "w")
        SeqIO.write(good_genes, output1, "fasta")
#        output2=open("/Volumes/Solomon_Lab/Megan/Spades_assembly/gdnablast/genomefastas/"+key+"MISSING.fasta", "w")
#        SeqIO.write(missing_genes, output2, "fasta")
    output1.close()
#    output2.close()



## Align each fasta file and write to alignment
from Bio.Align.Applications import MuscleCommandline
muscle_exe = r"/Users/meganm/Bin/muscle3.8.31_i86darwin64"


for key in refgene:
    in_file ="/Volumes/Solomon_Lab/Megan/Spades_assembly/gdnablast_50percent/genomefastas/"+key+".fasta"
    out_file ="/Volumes/Solomon_Lab/Megan/Spades_assembly/gdnablast_50percent/genomealignments/"+key+"_align.fasta"
    muscle_cline = MuscleCommandline(muscle_exe, input=in_file, out=out_file)
#    print(muscle_cline) ###execute alignment of all genes in the loop
    muscle_cline()


##Calculate pairwise differences of alignments


## Output table of each gene, the number of isolates in the alignment, the Avg pairwise dist between isolates



