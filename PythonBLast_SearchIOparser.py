#! /usr/bin/env python

from Bio import SearchIO

USAGE= """Provide a BLAST XML file to be used to parsed using Bio.python XML parser, input at the command line the following
options: PythonBLast_SearchIOparser.py path_to_input.xml outfile_name.txt Max_evalue"""

XMLFILE="/Users/meganm/Dropbox/Megans_Data/Zymoseptoria_tritici/ModEff_trialSCR_proteins.xml" #sys.argv[1] 
OUTFILENAME='Filtered_ModEFFBlast_lessthan5hits.txt'  #sys.argv[2]
QUERYNUM=1
HITNUM=1
OUTFILE=open(OUTFILENAME, 'w')
HEADER="Hit_Number\tQuery_name\tHit_id\tHit_Description\tE_value"
OUTFILE.write(HEADER+'\n')  
E_VALUE_THRESH=0.0001   #sys.argv[3]


blast_qresults= SearchIO.parse(XMLFILE,'blast-xml')

for blast_qresult in blast_qresults:
    if len(blast_qresult)>=1 and len(blast_qresult)<5:
        for hit in blast_qresult.hits:
            for hsp in blast_qresult.hsps:
                Outputstring= "%i\t%s\t%s\t%s\t%f" %(HITNUM,blast_qresult.id,hit.id,hit.description,hsp.evalue)
                OUTFILE.write(Outputstring+'\n')
                QUERYNUM=QUERYNUM+1
                HITNUM=HITNUM+1


