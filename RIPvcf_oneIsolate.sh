#! /bin/bash

vcffile=$1
isolate=$2
GATKrealign=$3

echo $vcffile

grep '#' $vcffile > headers.temp
cat $vcffile | grep -v '#' | awk '{if ( ($4 =="A" && $5 == "G") || ($4 == "G" && $5 == "A") || ($4 == "C" && $5 == "T") || ($4 == "T" && $5 == "C") ) print $0}' > riplike.temp
cat headers.temp riplike.temp > ""$isolate".riplike.vcf"

rm headers.temp
rm riplike.temp

kbinterval="../VCF/IPO323_intervals20kb.bed"

#perl ~/scripts/make_intervals.pl $ref.fai 100000 IPO323_intervals_100kb.bed

echo "-------------Counting RIP-like variants per 100kb for "$isolate"------------------------"
coverageBed -a $vcffile -b $kbinterval | awk {'print $1,$2,$3,$5'} > ""$isolate"_ALL_variants_20kb.hist"
echo "---------------------FINISHED ISOLATE "$isolate"-----------------"


echo "-------------Counting All variants per 100kb for "$isolate"------------------------"
coverageBed -a ""$isolate".riplike.vcf" -b $kbinterval | awk {'print $1,$2,$3,$5'} > ""$isolate"_RIP_variants_20kb.hist"
echo "---------------------FINISHED ISOLATE "$isolate"-----------------"


echo "-----------Counting All variants in genes for "isolate"--------------------------"




echo "----------Counting All RIPlike variants in genes for "isolate"-------------------"


