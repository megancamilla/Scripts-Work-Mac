#!/bin/bash
#  BWASW_denovomap.sh
#  
#
#  Created by Megan McDonald on 23/04/13.
#
###

ISOLATE=$1
echo "$ISOLATE"
INPATH=""$HOME"/Genomes/Velvet_assembly/"$ISOLATE"_denovo55/contigs.fa"
echo $INPATH
PAIR1=""$HOME"/Genomes/Trimmed_data/WAI"$ISOLATE"_R1.paired.trimmed.fq"
PAIR2=""$HOME"/Genomes/Trimmed_data/WAI"$ISOLATE"_R2.paired.trimmed.fq"
#REFPATH="~/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa"

### show usage if we don't give at least 2 command-line arguments when we call the script ###
if [ "$ISOLATE" == "" ]
 then
    echo "-----------------------------------------------------------------";
    echo "Align your RAW reads to your Velvet denovo assemblies with BWA";
    echo "Align your Velvet denovo assembly to the IPO323 reference genome";
    echo "USAGE";
    echo "VelvetCheck.sh IsolateNAME";
    echo "example usage:";
    echo " VelvetCheck.sh 320";
    echo "-----------------------------------------------------------------";
    exit 1;
fi


# Error Sanity check functions below###
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

echo "---------Assembling to Velvet de novo assembly to IPO323 --------------------";
bwa bwasw ~/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa $INPATH  ""$ISOLATE"_denovo_bwasw.sam"
#ckRes $? "bwa mem";
#ckFileSz ""$ISOLATE"_denovo_bwamap.sam";

echo "---------DONE Assembling to Velvet de novo assembly to IPO323 --------------------";

