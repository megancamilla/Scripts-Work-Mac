#!/bin/bash

USAGE="Bash script to blast any fasta file and report the results by numbers of hits"

blastp -db nr -query trial_3_fastaSeqs.fas -evalue 0.01 -outfmt 5 -out Mode_EFF.xml -remote

blastp -db nr -query ModEff_trialSCR_proteins.fa -evalue 0.01 -outfmt 5 -out ModEff_trialSCR_proteins.xml -remote
