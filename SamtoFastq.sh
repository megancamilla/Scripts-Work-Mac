#!/bin/bash

#  SamtoFastq.sh
#  
#
#  Created by Megan McDonald on 11/11/2014.
#
Isolate=`cat $1`
for line in $Isolate
do
echo "-------------Starting "$line"------------------------------"
java -jar /usr/local/bin/SamToFastq.jar INPUT=$line.lastz.unmapped.bam FASTQ=$line.lastz.unmapped.fastq

echo "-------------Finished "$line"------------------"
done
