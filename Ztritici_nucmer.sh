#!/bin/bash


###
echo Aligning WAI320 and IPO323
nucmer --maxgap=50000 -minmatch=100 --mincluster=100 --prefix=IPO323_WAI320 -mum /Users/meganm/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa /Users/meganm/Genomes/Velvet_assembly/320_denovo55/320_z100_noextend.final.scaffolds.fasta
echo Aligning WAI321 and IPO323
nucmer --maxgap=50000 -minmatch=100 --mincluster=100 --prefix=IPO323_WAI321 -mum /Users/meganm/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa /Users/meganm/Genomes/Velvet_assembly/321_denovo55/321_z100_noextend.final.scaffolds.fasta
echo Aligning WAI322 and IPO323
nucmer --maxgap=50000 -minmatch=100 --mincluster=100 --prefix=IPO323_WAI322 -mum /Users/meganm/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa /Users/meganm/Genomes/Velvet_assembly/322_denovo55/322_z100_noextend.final.scaffolds.fasta
echo Aligning WAI323 and IPO323
nucmer --maxgap=50000 -minmatch=100 --mincluster=100 --prefix=IPO323_WAI323 -mum /Users/meganm/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa /Users/meganm/Genomes/Velvet_assembly/323_denovo55/323_z100_noextend.final.scaffolds.fasta
echo Aligning WAI324 and IPO323
nucmer --maxgap=50000 -minmatch=100 --mincluster=100 --prefix=IPO323_WAI324 -mum /Users/meganm/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa /Users/meganm/Genomes/Velvet_assembly/324_denovo55/324_z100_noextend.final.scaffolds.fasta
echo Aligning WAI326 and IPO323
nucmer --maxgap=50000 -minmatch=100 --mincluster=100 --prefix=IPO323_WAI326 -mum /Users/meganm/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa /Users/meganm/Genomes/Velvet_assembly/326_denovo55/326_z100_noextend.final.scaffolds.fasta
echo Aligning WAI327 and IPO323
nucmer --maxgap=50000 -minmatch=100 --mincluster=100 --prefix=IPO323_WAI327 -mum /Users/meganm/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa /Users/meganm/Genomes/Velvet_assembly/327_denovo55/327_z100_noextend.final.scaffolds.fasta
echo Aligning WAI328 and IPO323
nucmer --maxgap=50000 -minmatch=100 --mincluster=100 --prefix=IPO323_WAI328 -mum /Users/meganm/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa /Users/meganm/Genomes/Velvet_assembly/328_denovo55/328_z100_noextend.final.scaffolds.fasta
echo Aligning WAI329 and IPO323
nucmer --maxgap=50000 -minmatch=100 --mincluster=100 --prefix=IPO323_WAI329 -mum /Users/meganm/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa /Users/meganm/Genomes/Velvet_assembly/329_denovo55/329_z100_noextend.final.scaffolds.fasta



show-coords -rc IPO323_WAI320.delta > IPO323_WAI320.coords
delta-filter -r -q IPO323_WAI320.delta > IPO323_WAI320.filter
show-snps -Clr IPO323_WAI320.filter > IPO323_WAI320.snps
show-tiling IPO323_WAI320.filter