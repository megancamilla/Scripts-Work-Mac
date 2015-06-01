#!/bin/bash

# Blast script where $1 = the fasta file you would like to query 
# $2 is the database that you would like to query
# $3 is the output name you would like to have


blastn -query $1 -db $2 -outfmt "7 qseqid qlen sseqid sstart send qstart qend evalue bitscore length pident" > $3.out
#blastn -task 'blastn-short' -query $1 -db $2  > $3.out



# Blastn_shell_taboutput.sh WAI320exon_IPOintersect_zercov.fa ~/Genomes/Velvet_assembly/BLASTdbs/WAI320_scaffolds WAI320_blast0covexonhits
# Blastn_shell_taboutput.sh WAI321exon_IPOintersect_zercov.fa ~/Genomes/Velvet_assembly/BLASTdbs/WAI321_scaffolds WAI321_blast0covexonhits
# Blastn_shell_taboutput.sh WAI322exon_IPOintersect_zercov.fa ~/Genomes/Velvet_assembly/BLASTdbs/WAI322_scaffolds WAI322_blast0covexonhits
# Blastn_shell_taboutput.sh WAI323exon_IPOintersect_zercov.fa ~/Genomes/Velvet_assembly/BLASTdbs/WAI323_scaffolds WAI323_blast0covexonhits
# Blastn_shell_taboutput.sh WAI324exon_IPOintersect_zercov.fa ~/Genomes/Velvet_assembly/BLASTdbs/WAI324_scaffolds WAI324_blast0covexonhits
# Blastn_shell_taboutput.sh WAI326exon_IPOintersect_zercov.fa ~/Genomes/Velvet_assembly/BLASTdbs/WAI326_scaffolds WAI326_blast0covexonhits
# Blastn_shell_taboutput.sh WAI327exon_IPOintersect_zercov.fa ~/Genomes/Velvet_assembly/BLASTdbs/WAI327_scaffolds WAI327_blast0covexonhits
# Blastn_shell_taboutput.sh WAI328exon_IPOintersect_zercov.fa ~/Genomes/Velvet_assembly/BLASTdbs/WAI328_scaffolds WAI328_blast0covexonhits
# Blastn_shell_taboutput.sh WAI329exon_IPOintersect_zercov.fa ~/Genomes/Velvet_assembly/BLASTdbs/WAI329_scaffolds WAI329_blast0covexonhits

# Blastn_shell_taboutput.sh ../augustus/filtered_augustus.codingseq ~/Genomes/Velvet_assembly/BLASTdbs/WAI320_scaffolds WAI320_Blast_abinitiogenes;
# Blastn_shell_taboutput.sh ../augustus/filtered_augustus.codingseq ~/Genomes/Velvet_assembly/BLASTdbs/WAI321_scaffolds WAI321_Blast_abinitiogenes;
# Blastn_shell_taboutput.sh ../augustus/filtered_augustus.codingseq ~/Genomes/Velvet_assembly/BLASTdbs/WAI322_scaffolds WAI322_Blast_abinitiogenes;
# Blastn_shell_taboutput.sh ../augustus/filtered_augustus.codingseq ~/Genomes/Velvet_assembly/BLASTdbs/WAI323_scaffolds WAI323_Blast_abinitiogenes;
# Blastn_shell_taboutput.sh ../augustus/filtered_augustus.codingseq ~/Genomes/Velvet_assembly/BLASTdbs/WAI324_scaffolds WAI324_Blast_abinitiogenes;
# Blastn_shell_taboutput.sh ../augustus/filtered_augustus.codingseq ~/Genomes/Velvet_assembly/BLASTdbs/WAI326_scaffolds WAI326_Blast_abinitiogenes;
# Blastn_shell_taboutput.sh ../augustus/filtered_augustus.codingseq ~/Genomes/Velvet_assembly/BLASTdbs/WAI327_scaffolds WAI327_Blast_abinitiogenes;
# Blastn_shell_taboutput.sh ../augustus/filtered_augustus.codingseq ~/Genomes/Velvet_assembly/BLASTdbs/WAI328_scaffolds WAI328_Blast_abinitiogenes;
# Blastn_shell_taboutput.sh ../augustus/filtered_augustus.codingseq ~/Genomes/Velvet_assembly/BLASTdbs/WAI329_scaffolds WAI329_Blast_abinitiogenes;
# Blastn_shell_taboutput.sh ../augustus/filtered_augustus.codingseq ~/Genomes/Velvet_assembly/BLASTdbs/zt79 zt79_Blast_abinitiogenes;
# Blastn_shell_taboutput.sh ../augustus/filtered_augustus.codingseq ~/Genomes/IPO323/IPO323_BLAST_DB IPO323_Blast_abinitiogenes;

#### October 2013
#Blastn_shell_taboutput.sh KO_round1.fas ~/Genomes/Velvet_assembly/BLASTdbs/zt79 KO_Flanks79.txt

### Jan 2014

##Blastn_shell_taboutput.sh KO_genes_fasta.txt ~/Genomes/Velvet_assembly/BLASTdbs/zt79 KO_genes_PeterandMegan.txt


## ToxA for Shao-yu
#Blastn_shell_taboutput.sh ToxA.fas ~/Genomes/Pnodorum_SN15 ToxAcds

