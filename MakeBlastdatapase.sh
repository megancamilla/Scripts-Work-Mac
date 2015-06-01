#!/bin/sh

#  MakeBlastdatapase.sh
#  Shell script to make a BLAST datbase from user defined data
#
#  Created by Megan McDonald on 16/07/13.
#
#
# Required items:
#Fasta infile, prefix name
#
#
#
USAGE="Provide in the following order and infile Fasta the and the Prefix that you would like to use to name your BLAST database.  This prefix will be used as the title of the database: Prefix.blast.database "

inFASTA=$1
Prefix=$2
Title=$3

dustmasker -in $inFASTA -infmt fasta -parse_seqids -outfmt maskinfo_asn1_bin -out $Prefix.dust.asnb

makeblastdb -in $inFASTA -input_type fasta -dbtype nucl -parse_seqids -mask_data $Prefix.dust.asnb -out $Prefix -title $Prefix.blast.database

blastdbcmd -db $Prefix -info

#mv $Prefix.* ../BLASTdbs


#MakeBlastdatapase.sh 321_z100_noextend.final.scaffolds.fasta  WAI321_scaffolds WAI321_BLAST_DB
#MakeBlastdatapase.sh 322_z100_noextend.final.scaffolds.fasta  WAI322_scaffolds WAI322_BLAST_DB
#MakeBlastdatapase.sh 323_z100_noextend.final.scaffolds.fasta  WAI323_scaffolds WAI323_BLAST_DB
#MakeBlastdatapase.sh 324_z100_noextend.final.scaffolds.fasta  WAI324_scaffolds WAI324_BLAST_DB
#MakeBlastdatapase.sh 326_z100_noextend.final.scaffolds.fasta  WAI326_scaffolds WAI326_BLAST_DB
#MakeBlastdatapase.sh 327_z100_noextend.final.scaffolds.fasta  WAI327_scaffolds WAI327_BLAST_DB
#MakeBlastdatapase.sh 328_z100_noextend.final.scaffolds.fasta  WAI328_scaffolds WAI328_BLAST_DB
#MakeBlastdatapase.sh 329_z100_noextend.final.scaffolds.fasta  WAI329_scaffolds WAI329_BLAST_DB
#MakeBlastdatapase.sh 329_z100_noextend.final.scaffolds.fasta  WAI329_scaffolds WAI329_BLAST_DB