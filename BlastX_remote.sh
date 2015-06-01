#!/bin/bash

#  BlastX_remote.sh
#  
#
#  Created by Megan McDonald on 18/12/13.
# Script to use the remote function on NCBI to Blast the Protein database
# current script uses blastx (translated nucleotide against the protein database)

#
#This script requires 3 inputs 1=path to fasta file, 2=desired evalue cutoff, 3=outfile name.
# These 3 required inputs should be typed after the script name separated by spaces, EXAMPLE BELOW:
# meganm$ BlastX_remote.sh genes.fas 0.001 genes_blastx.out

inFasta=$1
evaluelimit=$2
outname=$3

blastx -db nr -query $inFasta -evalue $evaluelimit -outfmt 5 -out $outname -remote

