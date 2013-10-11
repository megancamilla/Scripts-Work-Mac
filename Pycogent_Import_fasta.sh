#!/bin/sh

#  Pycogent_Import_fasta.sh
#  
#
#  Created by Megan McDonald on 25/01/13.
#

from cogent.parse.fasta import MinimalFastaParser
f=open('RangeBLAST_REV.out')
seqs = [(name, seq) for name, seq in MinimalFastaParser(f)]
print seqs