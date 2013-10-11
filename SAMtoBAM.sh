#!/bin/bash

# SAMtoBAM.sh
#  
#
#  Created by Megan McDonald on 8/04/13.
#


## Build and err function to report any problems that occur during execution of ###the script
err() {
  echo "$1...exiting";
  exit 1; # any non-0 code means error
}

### Build a function to check if a file has been created (i.e. did your sam to ##bam conversion actually make a file called "txt.bam"
## Note we are using our first error function here in our check file function

ckFile() {
  if [ ! -e "$1" ]; then
    err "$2 File '$1' not found";
  fi
}

### Build a check result function that prints DONE if code completes

ckRes() {
  if [ "$1" == "0" ]; then
    echo "..Done $2 `date`";
  else
    err "$2 returned non-0 exit code $1";
  fi
}

##### Build a check to see if your results file is 0bytes (i.e. file was ##created but its EMPTY!)

ckFileSz() {
  ckFile $1 $2;
  SZ=`ls -l $1 | awk '{print $5}'`;
  if [ "$SZ" == "0" ]; then
    err "$2 file '$1' is zero length";
  fi
}

######## ACTUAL CODE BELOW ############

INFILE=$1
OUT_PREFIX=$2

# show usage if we don't have 2 command-line arguments
if [ "$OUT_PREFIX" == "" ]; then
    echo "-----------------------------------------------------------------";
    echo "Convert a .SAM file to a .BAM file using samtools";
    echo " USAGE:";
    echo "BowtietoIGV.sh in_file out_pfx";
    echo " ";
    echo "  in_file   path to sam file ";
    echo "  out_pfx   Desired prefix of output files.";
    echo "Example:";
    echo "SAMtoBAM.sh infile.sam IsolateNAME";
    echo "----------------------------------------------------------------";
    exit 1;
fi

echo "----------------------------------------------";
echo "Creating bam file and checking alignment stats with Flagstat";
echo "----------------------------------------------";
samtools view -bSo $OUT_PREFIX.bam $INFILE
ckFileSz "$OUT_PREFIX.bam"
samtools flagstat $OUT_PREFIX.bam > $OUT_PREFIX.flag.txt;
ckRes $? "samtools view";
ckFileSz "$OUT_PREFIX.flag.txt";

echo "----------------------------------------------";
echo "Creating sorted bam file";
echo "----------------------------------------------";
samtools sort $OUT_PREFIX.bam $OUT_PREFIX.sorted;
ckFileSz "$OUT_PREFIX.sorted.bam";

echo "----------------------------------------------";
echo "Indexing sorted bam file";
echo "----------------------------------------------";
samtools index $OUT_PREFIX.sorted.bam;
ckFileSz "$OUT_PREFIX.sorted.bam.bai";





#### Generic Line telling us our script has completed

echo "---------------------------------------------------------";
echo "All bwa alignment tasks completed successfully!";
echo "`date`";
echo "---------------------------------------------------------";
exit 0;


