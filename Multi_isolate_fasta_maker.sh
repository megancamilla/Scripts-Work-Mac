#!/usr/bin/env python

#  Multi_isolate_fasta_maker.sh
#  
#
#  Created by Megan McDonald on 1/07/2014.
#
import csv
import sys

#flat_fasta_file=sys.argv[1]
flat_fasta_name='/Volumes/Solomon_Lab/Megan/Spades_assembly/gdnablast/priority_up_down/Prioritygenes_fastas.txt'
flat_fasta_open=open(flat_fasta_name, 'rU')

num=1

#write each line to a separate fasta file
outname=str(num)+".fasta"
outfile=open(outname, 'w')


for line in flat_fasta_open:
    outname=str(num)+".fasta"
    outfile=open(outname, 'w')
    line=line.strip()
    field=line.split('\t')
    wai320=field[0]
    wai320transcript=field[1]
    wai320fasta=field[2]
    wai321=field[3]
    wai321transcript=field[4]
    wai321fasta=field[5]
    wai322=field[6]
    wai322transcript=field[7]
    wai322fasta=field[8]
    wai323=field[9]
    wai323transcript=field[10]
    wai323fasta=field[11]
    wai324=field[12]
    wai324transcript=field[13]
    wai324fasta=field[14]
    wai326=field[15]
    wai326transcript=field[16]
    wai326fasta=field[17]
    wai327=field[18]
    wai327transcript=field[19]
    wai327fasta=field[20]
    wai328=field[21]
    wai328transcript=field[22]
    wai328fasta=field[23]
    wai329=field[24]
    wai329transcript=field[25]
    wai329fasta=field[26]
    wai320line=">%s-%s\n%s" % (wai320, wai320transcript, wai320fasta)
    wai321line=">%s-%s\n%s" % (wai321, wai321transcript, wai321fasta)
    wai322line=">%s-%s\n%s" % (wai322, wai322transcript, wai322fasta)
    wai323line=">%s-%s\n%s" % (wai323, wai323transcript, wai323fasta)
    wai324line=">%s-%s\n%s" % (wai324, wai324transcript, wai324fasta)
    wai326line=">%s-%s\n%s" % (wai326, wai326transcript, wai326fasta)
    wai327line=">%s-%s\n%s" % (wai327, wai327transcript, wai327fasta)
    wai328line=">%s-%s\n%s" % (wai328, wai328transcript, wai328fasta)
    wai329line=">%s-%s\n%s" % (wai329, wai329transcript, wai329fasta)
    outline=wai320line+"\n"+wai321line+"\n"+wai322line+"\n"+wai323line+"\n"+wai324line+"\n"+wai326line+"\n"+wai327line+"\n"+wai328line+"\n"+wai329line+"\n"
    num=num+1
    outfile.write(outline)
outfile.close()








