#! /bin/bash
### SSPACE SCAFFOLDING ####
## Basic script to create lib file NEEDED for SSPACE to run, move the trimmed paired end

echo "Usage SSPACE.sh <isolate_name>"

ISOLATE=$1
cd $HOME"/Genomes/Velvet_assembly/"$ISOLATE"_denovo55"
pwd
cp $HOME"/Genomes/Trimmed_data/WAI"$ISOLATE_R1".paired.trimmed.fq "$HOME"/Genomes/Velvet_assembly/"$ISOLATE"_denovo55/"
ls -la

#echo "Lib1 WAI"$ISOLATE"_R1.paired.trimmed.fq WAI"$ISOLATE"_R2.paired.trimmed.fq  200  0.25  FR" > $ISOLATE_lib.txt

#perl ~/Bin/SSPACE-BASIC-2.0_macOS_x86_64/SSPACE_Basic_v2.0.pl -s $ISOLATE_contigs.fa -l $ISOLATE_lib.txt -x 1 -m 95 -o 5 -r .8 -p 1

#rm ~/Genomes/Trimmed_data/WAI$ISOALTE_R*.paired.trimmed.fq



