#!/bin/bash
#### shell script following GATK2's variant calling workflow (Best Practices)
#### After Removing duplicates and sorting and adding READ_groups to your BAM file
#### Use this script to take your prepared BAM files and perform a local realignment

#Phase I Perform Local realignments, recalibrate your phred scoring and reduce you BAM files
# lose information that is not needed to identify variants

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

####### START ACTUAL CODE DOWN HERE INCLUDING USAGE! #####
ISOLATES=$1

### show usage if we don't give at least 1 command-line arguments when we call the script ###
if [ "$1" == "" ]
	then
	    echo "-----------------------------------------------------------------"
	    echo "USAGE:"
	    echo "USE A list of BAM files in ISOLATElist.txt to perform local realignment"
	    echo "Tools are in GATK RealignerTargetCreator and IndelRealigner"
	    echo "RealignerTargetCreator --> java -jar ~/Bin/GATK/GenomeAnalysisTK.jar -T RealignerTargetCreator -R Reference.fasta -I input.bam -o ISOLATE_realigner.intervals"
	    echo "IndelRealigner --> java -jar ~/Bin/GATK/GenomeAnalysisTK.jar -T IndelRealigner -R Reference.fasta -I input.bam -targetIntervals ISOLATE_realigner.intervals -o realigned.bam"
	    echo "BaseRecalibrator --> java -jar ~/Bin/GATK/GenomeAnalysisTK.jar -T BaseRecalibrator -R Reference.fasta -I realigned.bam -o recal.grp -plots recal.grp.pdf"
	    echo "example usage:"
	    echo "GATK_Realigner.sh ISOLATElist.txt"
	    echo "ISOLATElist.txt contains a line with each ISOLATEs name on a separate line \(WAI320 /r WAI321 ....\)"
	    echo "-----------------------------------------------------------------"
	    exit 1
	else
	ISOLATELINE=`cat $ISOLATES`
	for line in $ISOLATELINE
	  do
	  echo " ---------------------------------------------"
	  echo "Processing with RealignerTarget Creator $line"
	  ## use GATK to create the targets for realigning reads around indels
	  echo " ---------------------------------------------"
	  java -Xmx3g -jar ~/Bin/GATK/GenomeAnalysisTK.jar -T RealignerTargetCreator -R ~/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa -I $line.dedup.RG.bam -o $line.realigner.intervals
	  ckFileSz "$line.realigner.intervals"
	  
	  echo " ---------------------------------------------"
	  echo "Re-aligning $line"
	  ## use GATK to perform the realignments around indels
	  echo " ---------------------------------------------"
	  
	  #java -Xmx3g -jar ~/Bin/GATK/GenomeAnalysisTK.jar -T IndelRealigner -R ~/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa -I $line.dedup.RG.bam -targetIntervals $line.realigner.intervals -o $line.realign.bam
	  #ckFileSz "$line.realign.bam"
	  
	  echo " ---------------------------------------------"
	  echo "Recalibrate Base Qualities with $line"
	  echo " ---------------------------------------------"
	  ## Use GATK to re-calibrate the quality scores for bases based on their position (cycle) in the machine (remove machine introduced biases in quality scoring)
	  #java -Xmx3g -jar ~/Bin/GATK/GenomeAnalysisTK.jar -T BaseRecalibrator -R ~/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa -I $line.realign.bam -knownSites ~/Genomes/GATK_Variant_Detection/Ztritici.1000.20.filter.vcf -o $line.recal.grp -plots $line.recal.grp.pdf
	  #ckFileSz "$line.recal.grp"
	  
	  echo " ---------------------------------------------"
	  echo "Generate Plots to show Quality scores for $line before/after recalibration"
	  ## generate Plots to show the quality score both before and after the recalibration step
	  echo " ---------------------------------------------"
	  java -Xmx3g -jar ~/Bin/GATK/GenomeAnalysisTK.jar -l -T BaseRecalibrator -R ~/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa -I $line.realign.bam -knownSites ~/Genomes/GATK_Variant_Detection/Ztritici.1000.20.filter.vcf -BQSR $line.recal.grp -o $line.postrecal.grp -plots $line.post_recal.grp.pdf
	  #ckFileSz "line.postreacal.grp"
	  
	  echo " ---------------------------------------------"
	  echo " Replace the old quality scores with new recalibrated scores for $line"
	  ## use the Print reads command to replace the old quality scores with your new recalibrated scores, generate NEW recalibrated BAM file
	  echo " ---------------------------------------------"
	  java -Xmx3g -jar ~/Bin/GATK/GenomeAnalysisTK.jar -T PrintReads -R ~/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa -I $line.realign.bam -BQSR $line.recal.grp -o $line.recal.bam
	  #ckFileSz "$line.recal.bam"
	  
	  echo " ---------------------------------------------"
	  echo "Reduce BAM file for $line "
	  # use GATK to reduce the bam file removing conserved areas and leaving the information for reads around indels and SNPs
	  echo " ---------------------------------------------"
	  java -Xmx3g -jar ~/Bin/GATK/GenomeAnalysisTK.jar -T ReduceReads -R ~/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa -I $line.recal.bam -o $line.reduced.bam
	  #ckFileSz "$line.reduced.bam"
	  done

fi




