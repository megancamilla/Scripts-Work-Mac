#!/bin/bash

#$ -cwd
#$ -m be
#$ -o MEMEtest_12.out
#$ -j y
#$ -V
#$ -q bonus.q
#$ -pe threads 4
date
meme_p Test_UTR.fas -p4 -mod zoops -text -dna -minw 4 -maxw 25
date