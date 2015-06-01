java -Xmx4g -jar ~/Bin/GATK/GenomeAnalysisTK.jar \
   -R ~/Genomes/IPO323/Mycosphaerella_graminicola.allmasked.fa \
   -T FastaAlternateReferenceMaker \
   -o WAI321.output.fasta \
   -L ~/Genomes/GATK_Variant_Detection/Bedfiles/intervals.intervals \
   --variant ~/Genomes/GATK_Variant_Detection/SingleVCF/WAI321.GATK.vcf
