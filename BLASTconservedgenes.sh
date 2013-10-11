#!/bin/bash

# Blast script where $1 = the fasta file you would like to query 
# $2 is the database that you would like to query
# $3 is the output name you would like to have


blastn -query $1 -db $2 -outfmt "7 qseqid qlen sseqid sstart send qstart qend evalue bitscore length pident" > $3.out


# Blastn_shell_taboutput.sh Conserved_genes_short.fas ~/Genomes/Velvet_assembly/BLASTdbs/WAI320_scaffolds WAI320_conservedgenes;
# Blastn_shell_taboutput.sh Conserved_genes_short.fas ~/Genomes/Velvet_assembly/BLASTdbs/WAI321_scaffolds WAI321_conservedgenes;
# Blastn_shell_taboutput.sh Conserved_genes_short.fas ~/Genomes/Velvet_assembly/BLASTdbs/WAI322_scaffolds WAI322_conservedgenes;
# Blastn_shell_taboutput.sh Conserved_genes_short.fas ~/Genomes/Velvet_assembly/BLASTdbs/WAI323_scaffolds WAI323_conservedgenes;
# Blastn_shell_taboutput.sh Conserved_genes_short.fas ~/Genomes/Velvet_assembly/BLASTdbs/WAI324_scaffolds WAI324_conservedgenes;
# Blastn_shell_taboutput.sh Conserved_genes_short.fas ~/Genomes/Velvet_assembly/BLASTdbs/WAI326_scaffolds WAI326_conservedgenes;
# Blastn_shell_taboutput.sh Conserved_genes_short.fas ~/Genomes/Velvet_assembly/BLASTdbs/WAI327_scaffolds WAI327_conservedgenes;
# Blastn_shell_taboutput.sh Conserved_genes_short.fas ~/Genomes/Velvet_assembly/BLASTdbs/WAI328_scaffolds WAI328_conservedgenes;
# Blastn_shell_taboutput.sh Conserved_genes_short.fas ~/Genomes/Velvet_assembly/BLASTdbs/WAI329_scaffolds WAI329_conservedgenes;
# Blastn_shell_taboutput.sh Conserved_genes_short.fas ~/Genomes/Velvet_assembly/BLASTdbs/zt79 zt79_Blast_conservedgenes;