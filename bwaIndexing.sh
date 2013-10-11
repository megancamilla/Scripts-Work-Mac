#! /bin/bash

for f in ~/Genomes/Velvet_assembly/*_denovo55/*_z100_noextend.final.scaffolds.fasta; do
bwa index $f 
done 