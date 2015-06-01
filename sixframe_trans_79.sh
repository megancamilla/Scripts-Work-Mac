#!/bin/sh
#$ -j y
#$ -pe threads 1
#$ -o /home/meganm/genomealignments/logs/

#getorf -minsize 300 -sequence /Volumes/Solomon_Lab/Megan/Spades_assembly/Complete_genomes/WAI323.spades.fa -output /Volumes/Solomon_Lab/Megan/sixframe/WAI323.six.orf.fa

getorf -minsize 300 -sequence ~/genomealignments/reference/st79.final.tiled.psuedochromosome.fasta -outseq ~/genomealignments/sixframe/zt79.six.orf.fa