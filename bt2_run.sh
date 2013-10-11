#! /bin/bash
#$ -cwd
#$ -j y
#$ -V
#$ -o WAI320_bt2.out
#$ -m ae
#$ -M megan.mcdonald@anu.edu.au
#$ -pe threads 4
#$ -q bonus.q

bowtie2 -p 4 -x /home/meganm/Reference_Genome/z.tritici --sensitive -q -1 WAI320_R1.paired.trimmed.fq.gz -2 WAI320_R2.paired.trimmed.fq.gz \
-S WAI320.bt2.sam