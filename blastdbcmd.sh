#!/bin/bash

OIFS="$IFS"
IFS=$'\n'

for line in $(<Range_BLASTin.txt); do
blastdbcmd -db pn_maksed_db $line;
echo One line
done >>output.txt

IFS="$OIFS"