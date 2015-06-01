set -e
mygenomes=(`ls /home/meganm/Spades_denovo/*.fa.gz`)
thisgenome=${mygenomes[$((SGE_TASK_ID-1))]}
isolatename=`basename $thisgenome | cut -f1 -d '.'`
protoutput="/home/meganm/genomealignments/sixframe/"$isolatename".orf.fa"
#reference="/home/meganm/genomealignments/reference/Zymoseptoria_tritici.MG2.22.dna.toplevel.fa"
fifo="/home/meganm/genomealignments/sixframe/"$isolatename".fifo"
[ -f $fifo ] && rm $fifo
mkfifo $fifo
unpigz -c $thisgenome > $fifo &
getorf -minsize 300 -sequence $fifo -output $protoutput
#blastn -query $fifo -task blastn -db $reference -out $blastoutput -evalue 1e-3 -outfmt 6 -num_threads 11
rm $fifo

