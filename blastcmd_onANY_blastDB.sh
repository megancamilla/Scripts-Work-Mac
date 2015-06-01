#!/bin/bash

### Blast script where $1=input file with coordinates to extract
### and $2 is the genome blast db you would like to use
### and $3 is the name of the output fasta file

cmdfile=$1
cat $cmdfile | grep -v '^#'>input
genomedb=$2
echo Start!
while read line; do
 #elif #echo "blastdbcmd -db $genomedb "$line" "
 blastdbcmd -db $genomedb $line
done <input >$3.fa
rm input
echo Finished!


# Blastcmd_onANY_blastDB.sh ~/Dropbox/Megans_data/Zymoseptoria_tritici/Phenotype_clustering/blastcmdWAI320.txt ~/Genomes/Velvet_assembly/BLASTdbs/WAI320_scaffolds WAI320_conservedgenes
# Blastcmd_onANY_blastDB.sh ~/Dropbox/Megans_data/Zymoseptoria_tritici/Phenotype_clustering/blastcmdWAI321.txt ~/Genomes/Velvet_assembly/BLASTdbs/WAI321_scaffolds WAI321_conservedgenes;
# Blastcmd_onANY_blastDB.sh ~/Dropbox/Megans_data/Zymoseptoria_tritici/Phenotype_clustering/blastcmdWAI322.txt ~/Genomes/Velvet_assembly/BLASTdbs/WAI322_scaffolds WAI322_conservedgenes;
# Blastcmd_onANY_blastDB.sh ~/Dropbox/Megans_data/Zymoseptoria_tritici/Phenotype_clustering/blastcmdWAI323.txt ~/Genomes/Velvet_assembly/BLASTdbs/WAI323_scaffolds WAI323_conservedgenes;
# Blastcmd_onANY_blastDB.sh ~/Dropbox/Megans_data/Zymoseptoria_tritici/Phenotype_clustering/blastcmdWAI324.txt ~/Genomes/Velvet_assembly/BLASTdbs/WAI324_scaffolds WAI324_conservedgenes;
# Blastcmd_onANY_blastDB.sh ~/Dropbox/Megans_data/Zymoseptoria_tritici/Phenotype_clustering/blastcmdWAI326.txt ~/Genomes/Velvet_assembly/BLASTdbs/WAI326_scaffolds WAI326_conservedgenes;
# Blastcmd_onANY_blastDB.sh ~/Dropbox/Megans_data/Zymoseptoria_tritici/Phenotype_clustering/blastcmdWAI327.txt ~/Genomes/Velvet_assembly/BLASTdbs/WAI327_scaffolds WAI327_conservedgenes;
# Blastcmd_onANY_blastDB.sh ~/Dropbox/Megans_data/Zymoseptoria_tritici/Phenotype_clustering/blastcmdWAI328.txt ~/Genomes/Velvet_assembly/BLASTdbs/WAI328_scaffolds WAI328_conservedgenes;
# Blastcmd_onANY_blastDB.sh ~/Dropbox/Megans_data/Zymoseptoria_tritici/Phenotype_clustering/blastcmdWAI329.txt ~/Genomes/Velvet_assembly/BLASTdbs/WAI329_scaffolds WAI329_conservedgenes;
# Blastcmd_onANY_blastDB.sh ~/Dropbox/Megans_data/Zymoseptoria_tritici/Phenotype_clustering/blastcmdzt79.txt ~/Genomes/Velvet_assembly/BLASTdbs/zt79 zt79_conservedgenes;

