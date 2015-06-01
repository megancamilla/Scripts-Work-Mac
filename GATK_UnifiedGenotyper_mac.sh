#!/bin/bash
##Use GATK to call variants with UnifiedGenotyper.  Input is reduced BAM files# Error Sanity check functions below###
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

####### START ACTUAL CODE DOWN HERE INCLUDING USAGE! #####


### show usage if we don't give at least 1 command-line arguments when we call the script ###
if [ "$1" == "" ]
	then
	    echo "-----------------------------------------------------------------"
	    echo "USAGE:"
	    echo "Enter  the BAM file you would like to analyse on the command line"
	    echo "Tool used is GATK Unified Genotyper with ploidy set to 1"
	    echo "UnifiedGenotyper --> java -jar ~/bin/GATK/GenomeAnalysisTK.jar -T UnifiedGenotyper -R Reference.fasta -I $1  -o $1.all.vcf";
	    echo "example usage:"
	    echo "GATK_Realigner.sh WAI321.reduced.bam "
	    echo "-----------------------------------------------------------------"
	    exit 1
	else
	 echo "Computing variants for: $@"	 
	 java -Xmx10g -jar ~/bin/GATK/GenomeAnalysisTK.jar -T UnifiedGenotyper -R /Users/meganm/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa \
	 -I $1 -o $2.GATK.vcf -ploidy 1 -stand_call_conf 50 -glm BOTH
	 ckFileSz "$2.GATK.vcf"
fi
