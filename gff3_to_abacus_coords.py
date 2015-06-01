#!/usr/bin/env python
### Pipeline for going from gff file...look at specific transcripts based on their id
### Find the start position of each of these transcripts
### Adjust their start position based on a concatenated genome

#(These are the start coordinates of each chromosome if the genome was conacatenated, they are +1 adjusted)
ConCatChr={
'chr_1': 1,
'chr_2': 6088798,
'chr_3': 9948909,
'chr_4': 13454290,
'chr_5': 16334301,
'chr_6': 19196104,
'chr_7': 21871055,
'chr_8': 24536335,
'chr_9': 26979907,
'chr_10': 29122382,
'chr_11': 30804957,
'chr_12': 32429249,
'chr_13': 33891873,
'chr_14': 35077647,
'chr_15': 35850745,
'chr_16': 36490246,
'chr_17': 37097290,
'chr_18': 37681389,
'chr_19': 38255087,
'chr_20': 38804934,
'chr_21': 39277039 }

## Read in Transcript GFF file 

GFFtransPATH='/Users/meganm/Genomes/IPO323/Gffs_ensemble/Ztritici_transcripts_test.gff3' ### sys.argv[1]
GFFtrans= open(GFFtransPATH, 'r')

PREFIX=str(320) ## sys.argv[2]

CrunchPATH=str('/Volumes/Solomon_Lab/Megan/ABACAS/'+PREFIX+'/abacus_'+PREFIX+'.crunch')
Crunch= open(CrunchPATH, 'r')

outname= str(PREFIX+'abacus_coords.txt')
OUTFILE= open(outname, 'w')

protein_list=[]
###get each line for each gene of interest

#def convert_gff(gffFile):
GFFtrans= open(GFFtransPATH, 'r')

for line in GFFtrans:
    line=line.strip()
    if not line:
         continue
    if line[0] == '#':
       continue
    field= line.split('\t')
    chr=field[0]
    AdjStart=int(field[3])+ConCatChr[chr]
    AdjEnd=int(field[4])+ConCatChr[chr]
    newline="%s\t%s\t%s\t%i\t%i\t%s\t%s\t%s\t%s" % (field[0],field[1],field[2],AdjStart,AdjEnd,field[5],field[6],field[7],field[8])
    OUTFILE.write(newline +"\n")



GFFtrans.close
OUTFILE.close







