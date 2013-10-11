#! /bin/bash
## ONE line code to converte a bam file to a fasta file using samtools and awk
## USAGE
##samtools view filename.bam | awk '{OFS="\t"; print ">"$1"\n"$10}' - > filename.fasta

INPUT=$1

awk '{OFS="\t"; print ">"$1"\n"$10}' $INPUT > $INPUT.fasta