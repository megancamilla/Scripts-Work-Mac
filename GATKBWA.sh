#!/bin/bash

## shell script following GATK's variant calling workflow (Best Practices)

#Phase I Map reads using BWA and get ordered BAM files
ISOLATE=$1
PAIR1=""$HOME"/Genomes/Trimmed_data/"$ISOLATE"_R1.paired.trimmed.fq"
PAIR2=""$HOME"/Genomes/Trimmed_data/"$ISOLATE"_R2.paired.trimmed.fq"

### show usage if we don't give at least 2 command-line arguments when we call the script ###
if [ "$ISOLATE" == "" ]; then
    echo "-----------------------------------------------------------------";
    echo "Align your RAW reads to your Velvet denovo assemblies with BWA";
    echo "First align the forward reads, followed by the reverse reads independently";
    echo "Then index both forward and reverse alignments and align them with PE algorithm";
    echo "USAGE";
    echo "GATKBWA.sh IsolateNAME";
    echo "example usage:";
    echo " GATKBWA.sh 320";
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

echo "-----------------------------------------------------------------";
echo "---------Assembling forward reads to IPO323 --------------------";
echo "-----------------------------------------------------------------";

bwa aln ~/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa $PAIR1 > $ISOLATE.R1.sai;
ckRes $? "bwa aln";
ckFileSz "$ISOLATE.R1.sai";


echo "-----------------------------------------------------------------";
echo "---------Assembling Reverse reads to IPO323 --------------------";
echo "-----------------------------------------------------------------";

bwa aln ~/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa $PAIR2 > $ISOLATE.R2.sai;
ckRes $? "bwa aln";
ckFileSz "$ISOLATE.R2.sai";


echo "-----------------------------------------------------------------";
echo "---------Assembling Paired reads to IPO323 --------------------";
echo "-----------------------------------------------------------------";

bwa sampe ~/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa $ISOLATE.R1.sai $ISOLATE.R2.sai \
$PAIR1 $PAIR2 > $ISOLATE.PE.sam
ckRes $? "bwa sampe";
ckFileSz "$ISOLATE.PE.sam";

ASSEMBLY="$ISOLATE.PE.sam";
SORTED="$ISOLATE.sorted.bam"
METRICS="$ISOLATE.metrics";
DEDUP="$ISOLATE.dedup.bam";
RG="$ISOLATE.dedup.RG.bam";


echo "-----------------------------------------------------------------";
echo "------------------- Sorting PE SAM file --------------------------";
echo "-----------------------------------------------------------------";

java -Xmx3g -jar /usr/local/bin/SortSam.jar VALIDATION_STRINGENCY=LENIENT I=$ASSEMBLY O=$SORTED SO=coordinate;

echo "-----------------------------------------------------------------";
echo "-------------- Removing duplicates from BAM file -----------------";
echo "-----------------------------------------------------------------";

java -Xmx2g -jar /usr/local/bin/MarkDuplicates.jar VALIDATION_STRINGENCY=LENIENT I=$SORTED  M=$METRICS O=$DEDUP;

echo "-----------------------------------------------------------------";
echo "-------------- Adding READ_Groups to BAM file -----------------";
echo "-----------------------------------------------------------------";

java -Xmx2g -jar /usr/local/bin/AddOrReplaceReadGroups.jar VALIDATION_STRINGENCY=LENIENT CREATE_INDEX=TRUE I=$DEDUP O=$RG \
RGID=id RGLB=illumina-TruSeq RGPL=Illumina_HiSeq RGPU=D1GM8ACXX RGSM=$ISOLATE \
RGCN=GDU_ANU RGDT=09012013;

echo "-----------------------------------------------------------------";
echo "-- Finished preparing BAM FILE for GATK Variant detection -------";
echo "-----------------------------------------------------------------";


