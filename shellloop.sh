#!/bin/bash

OIFS="$IFS"
IFS=$'\n'
for line in $(<Range_BLASTin.txt); do
echo $line
done >>output.txt

IFS="OIFS"
