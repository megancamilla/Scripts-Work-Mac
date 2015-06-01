#!/bin/sh
#$ -j y
#$ -N blastn
#$ -pe threads 11
#$ -t 1-9
#$ -o /home/meganm/genomealignments/logs/
set -e
mygenomes=(`ls /home/meganm/Spades_denovo/*.fa.gz`)
thisgenome=${mygenomes[$((SGE_TASK_ID-1))]}
isolatename=`basename $thisgenome | cut -f1 -d '.'`
blastoutput="/home/meganm/genomealignments/alignments/"$isolatename".blastn.out"
reference="/home/meganm/genomealignments/reference/Zymoseptoria_tritici.MG2.22.dna.toplevel.fa"
fifo="/home/meganm/genomealignments/alignments/"$isolatename".fifo"
[ -f $fifo ] && rm $fifo
mkfifo $fifo
unpigz -c $thisgenome > $fifo &
blastn -query $fifo -task blastn -db $reference -out $blastoutput -evalue 1e-3 -outfmt 6 -num_threads 11
rm $fifo
