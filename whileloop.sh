#!/bin/bash

filename='secreted_proteins.txtEARLY_OUT.txtREV_OUT.txt'
echo Start
while read line; do
blastdbcmd -db pn_maksed_db $line
done < $filename >>secreted_protein_EARLY_REV_OUT.out
echo Finished!