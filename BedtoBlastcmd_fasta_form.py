#!/usr/bin/env python

#  BedtoBlastcmd_fasta_form.py
#  
#
#  Created by Megan McDonald on 16/07/13.
#
# Convert a bed file to a command line for coordinates on the reference chromosome.
# Format needed for BLASTcmd "-entry scaffold_1 -range 1000-2000"

# Format of the bed file "chr_# start stop coverage"

import sys

USAGE= """Take a four column bed file and convert it to regions for extraction with BLASTcmd"""

#if len(sys.argv)<0:
#    print USAGE
#else:
InFILENAME= sys.argv[1]
INFILE= open(InFILENAME,'r')
OutFILENAME= sys.argv[2]
OutFILE= open(OutFILENAME, 'w')

for line in INFILE:
    line= line.strip('\n')
    ElementList= line.split('\t')
    STARTpos=ElementList[1]
    STOPpos=ElementList[2]
    if (int(STOPpos)-int(STARTpos))>100:
        OutputSTRING= "-entry %s -range %d-%d" % (ElementList[0],int(STARTpos),int(STOPpos))
        OutFILE.write(OutputSTRING+"\n")


INFILE.close()
OutFILE.close()



#BedtoBlastcmd_fasta_form.py WAI320.intersectexononlyzeroCOV.bed WAI320_intersect_exononlyzero_blastcmd.txt
#BedtoBlastcmd_fasta_form.py WAI321.intersectexononlyzeroCOV.bed WAI321_intersect_exononlyzero_blastcmd.txt
#BedtoBlastcmd_fasta_form.py WAI322.intersectexononlyzeroCOV.bed WAI322_intersect_exononlyzero_blastcmd.txt
#BedtoBlastcmd_fasta_form.py WAI323.intersectexononlyzeroCOV.bed WAI323_intersect_exononlyzero_blastcmd.txt
#BedtoBlastcmd_fasta_form.py WAI324.intersectexononlyzeroCOV.bed WAI324_intersect_exononlyzero_blastcmd.txt
#BedtoBlastcmd_fasta_form.py WAI326.intersectexononlyzeroCOV.bed WAI326_intersect_exononlyzero_blastcmd.txt
#BedtoBlastcmd_fasta_form.py WAI327.intersectexononlyzeroCOV.bed WAI327_intersect_exononlyzero_blastcmd.txt
#BedtoBlastcmd_fasta_form.py WAI328.intersectexononlyzeroCOV.bed WAI328_intersect_exononlyzero_blastcmd.txt
#BedtoBlastcmd_fasta_form.py WAI329.intersectexononlyzeroCOV.bed WAI329_intersect_exononlyzero_blastcmd.txt