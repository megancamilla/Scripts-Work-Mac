#!/usr/bin/env python

from Bio.Blast import NCBIXML
from Bio import SeqIO
import sys

USAGE= """Provide a BLAST XML  file to be used to parsed using Bio.python XML parser"""

XMLFILE="/Users/meganm/Dropbox/Megans_Data/Zymoseptoria_tritici/ModEff_trialSCR_proteins.xml" #sys.argv[1] 
E_VALUE_THRESH= 0.0001
NUMALIGN=2
OUTFILENAME='Filtered_ModEFFBlast.txt'
QUERYNUM=0

c
blast_records=NCBIXML.parse(open(XMLFILE, 'rU'))
for blast_record in blast_records:
    for description in blast_record.descriptions:
        for alignment in blast_record.alignments:
            for hsp in alignment.hsps:
                if hsp.expect < E_VALUE_THRESH and len(alignment.hsps) == 1:
                    Outputstring= "####%i######\n%s\t%s\te_value:%f\t" %(QUERYNUM, blast_record.query ,alignment.title, hsp.expect)
                    OUTFILE.write(Outputstring+'\n')
                    QUERYNUM=QUERYNUM+1


OUTFILE.close
blast_records.close
