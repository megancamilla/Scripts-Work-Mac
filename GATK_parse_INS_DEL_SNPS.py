#!/usr/bin/env python

## Python script used to pull out variable lines in the GATK analysis VCF file
## Need to pull out the last nine columns and look at the first number 
## If all of these genotypes = 1 then this variant is not interesting
##### SECONDARY goal of script is to look at the actual variant if Column3 < column4 then
# this is an insertion
### Column 3< column 4 = insertion
### Column 3 < Column 4 = deletion
### Column 3 = Column 4 = SNP

import sys

USAGE= """ Find variable positions in a GATK 9 isolate VCF file.  Genotypes are in the last 9 columns
This script will separate ONE VCF file into THREE separate files: INSERTIONS, DELETIONS, SNPS"""

if len(sys.argv)<1:
    print USAGE
else:
    InFileName=sys.argv[1]
###  Used for writing and testing script:   InFileName="Ztritici.GATK.HIGHEFF.chr1_13.vcf"
    InFile= open(InFileName, 'r')

    InsertionNameOUT= InFileName + ".INSERTIONS.vcf"
    InsertionOUT= open(InsertionNameOUT, 'w')
    DeletionNameOUT= InFileName + ".DELETIONS.vcf"
    DeletionOUT= open(DeletionNameOUT, 'w')
    SNPNameOUT= InFileName + ".SNPS.vcf"
    SNPOUT= open(SNPNameOUT, 'w')


for line in InFile:
    line= line.strip('\n')
    ElementList= line.split('\t')
    ELfourline=ElementList[4]
    Elfour=ELfourline.split(',')
    ### Partition each isolate based on its genotype line
    WAI320line=ElementList[9]
    WAI320geno=WAI320line.split(':')
    
    WAI321line=ElementList[10]
    WAI321geno=WAI321line.split(':')
    
    WAI322line=ElementList[11]
    WAI322geno=WAI322line.split(':')
    
    WAI323line=ElementList[12]
    WAI323geno=WAI323line.split(':')
    
    WAI324line=ElementList[13]
    WAI324geno=WAI324line.split(':')
    
    WAI326line=ElementList[14]
    WAI326geno=WAI326line.split(':')
    
    WAI327line=ElementList[15]
    WAI327geno=WAI327line.split(':')
    
    WAI328line=ElementList[16]
    WAI328geno=WAI328line.split(':')
    
    WAI329line=ElementList[17]
    WAI329geno=WAI329line.split(':')
    
    if WAI320geno[0]==WAI321geno[0]==WAI322geno[0]==WAI323geno[0]==WAI324geno[0]==WAI326geno[0]==WAI327geno[0]==WAI328geno[0]==WAI329geno[0]:
        continue
    elif len(ElementList[3]) < len(Elfour[0]):
        Outstring='\t'.join(ElementList)
        InsertionOUT.write(Outstring + "\n")
    elif len(ElementList[3]) > len(Elfour[0]):
        Outstring='\t'.join(ElementList)
        DeletionOUT.write(Outstring + "\n")
    elif len(ElementList[3]) == len(Elfour[0]):
        Outstring='\t'.join(ElementList)
        SNPOUT.write(Outstring +"\n")

InFile.close()
InsertionOUT.close()
DeletionOUT.close()
SNPOUT.close()




