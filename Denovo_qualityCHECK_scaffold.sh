#!/bin/bash
### Shell script to double check that my raw reads map back to the Velvet de novo assembly
#
#
#
# Secondary function to align the de novo Velvet assembly to the reference IPO323
###
ISOLATE=$1
echo "$ISOLATE"
INPATH=""$HOME"/Genomes/Velvet_assembly/"$ISOLATE"_denovo55/"$ISOLATE"_z100_noextend.final.scaffolds.fasta"
echo $INPATH
PAIR1=""$HOME"/Genomes/Velvet_assembly/"$ISOLATE"_denovo55/WAI"$ISOLATE"_R1.paired.trimmed.fq"
PAIR2=""$HOME"/Genomes/Velvet_assembly/"$ISOLATE"_denovo55/WAI"$ISOLATE"_R2.paired.trimmed.fq"
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
bwa mem -H -M ~/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa $INPATH > ""$ISOLATE"_z100_denovo_torefHARDCLIP.sam"
#ckRes $? "bwa mem";
#ckFileSz ""$ISOLATE"_denovo_bwamap.sam";

echo "---------DONE Assembling to Velvet de novo assembly to IPO323 --------------------";


#echo "---------Assembling trimmed PE reads to Velvet de novo assembly--------------------";
#bwa mem -t 4 $INPATH $PAIR1 $PAIR2 > "WAI"$ISOLATE"_z100.denovo_CHECK.sam"
#ckRes $? "bwa mem";
#ckFileSz "WAI"$ISOLATE".denovo_CHECK.sam";

#echo "---------DONE Assembling trimmed PE reads to Velvet de novo assembly--------------------";