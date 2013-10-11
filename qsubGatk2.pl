#!/usr/bin/perl -w

use strict;
use Data::Dumper;

my $base_dir = "/home/data/projects/easteal/GATK2/";
my $bam_dir = "/home/data/projects/easteal/BAM2/";
my $read_dir = "/home/data/projects/easteal/data2/";
my $tmp_dir = "/home/data/tmp";
my $femalereference = "/home/data/bio/seq/e66/homosapiens.e66.female.fa";
#my $malereference = "/home/data/bio/seq/e66/homosapiens.e66.male.fa";
my $malereference = "/home/hardip/reference/homosapiens.e66.male.fa";
my $ncbidbsnpvcf = "/home/data/bio/variants/human/ncbi/00-All.vcf";
my $gatkhapmapvcf = "/home/data/bio/GATK/bundle/1.5/b37/hapmap_3.3.b37.sites.vcf";
my $gatkdbsnpvcf = "/home/data/bio/GATK/bundle/1.5/b37/dbsnp_135.b37.vcf";
my $gatkomnivcf = "/home/data/bio/GATK/bundle/1.5/b37/1000G_omni2.5.b37.sites.vcf";
my $gatkindelvcf = "/home/data/bio/GATK/bundle/1.5/b37/Mills_and_1000G_gold_standard.indels.b37.vcf";
my $gatkbinary = "/usr/local/jar/GenomeAnalysisTK.jar";
my $markdupbinary = "/usr/local/jar/MarkDuplicates.jar";
my $covaranalysisbinary = "/usr/local/jar/AnalyzeCovariates.jar";
my $targetregions = "/home/hardip/reference/TruSeqExomeTargetedRegions.bed";
my $offtargetregions = "/home/hardip/reference/TruSeqExomeOffTargetRegions.bed";

my $bwabin = "bwa";
my $bamtoolsbin = "bamtools";
my $coverageBedbinary = "coverageBed";
my $timecommand = "qsub -b y -j y 'date'";
my %config = (); ###inferred from directory

my $maxthreads = 12;
my $maxgbmem = 46;
my $javaoverhead = 9;
my $vfperthread=sprintf "%.1fG",$maxgbmem/$maxthreads;
my $hvperthread=sprintf "%.1fG",($maxgbmem+0.1)/$maxthreads;
my $vfonethread=sprintf "%.1fG",$maxgbmem;
my $hvonethread=sprintf "%.1fG",$maxgbmem+0.1;
my $javaonethread=sprintf "%dm",($maxgbmem-$javaoverhead)*1000;
my $javaperthread=sprintf "%dm",($maxgbmem-$javaoverhead)*1000/$maxthreads;

####identify all files
my @files=();
opendir DIR,$read_dir;
my @dirs=map{"$read_dir$_"} grep {/^Sample_/} readdir DIR;
closedir DIR;
foreach my $dir(@dirs) {
	opendir DIR,$dir;
	push @files,map{"$dir/$_"} grep {/\.fastq.gz$/} readdir DIR;
	closedir DIR;
}
foreach my $file (@files){
  print STDERR "considering $file\n";
#  if ($file =~ /.*\/([^\/]+)\/(\S+_[ACGT]+_L\d+)_(R\d)_001\.fastq\.gz$/){
  if ($file =~ /.*\/([^\/]+)\/(\S+_[ACGT]+_L001)_(R1)_001\.fastq\.gz$/){
    print STDERR "Sample = $1\n";
    my $sampleid = "$2";
    my $fragmentend = $3;
    $config{$sampleid}{'fastqfiles'}{$fragmentend} = $file; ###add the file names to R1 and R2 variable, and it is this way because up to the generation of sai files they have to be individually identified, then its all good
    $config{$sampleid}{'saifiles'}{$fragmentend} = "$base_dir$sampleid"."_$fragmentend.sai";
    $config{$sampleid}{'processlog'}= "$base_dir$sampleid.processlog"; ###get the sample id into config file
    #####RG String for sampe commmand
    $config{$sampleid}{'rgstring'} = "\@RG\tID:$sampleid\tSM:$sampleid\tPL:ILLUMINA\tLB:$sampleid"; #####essential for GATK to work
    #####sampe to generate bam file
    $config{$sampleid}{'rawbamfile'} = "$bam_dir$sampleid.bam";
    #####sort and index bam file
    $config{$sampleid}{'rawsortedbamfile'} = "$bam_dir$sampleid.sorted.bam";

    #####target and off target coverage before dedup
    $config{$sampleid}{'targetcoveragefile'} = "$base_dir$sampleid.ontarget.bed";
    $config{$sampleid}{'offtargetcoveragefile'} = "$base_dir$sampleid.offtarget.bed";
    #####remove duplicates
#    $config{$sampleid}{'dedupbamfile'} = "$base_dir$sampleid.dedup.bam";
    $config{$sampleid}{'dedupbamfile'} = "$base_dir$sampleid.rmdup.bam";
    $config{$sampleid}{'dedupmetricsfile'} = "$base_dir$sampleid.dedup.txt";
    #####target and off target coverage after dedup
    $config{$sampleid}{'targetcoveragefilededup'} = "$base_dir$sampleid.ontarget.dedup.bed";
    $config{$sampleid}{'offtargetcoveragefilededup'} = "$base_dir$sampleid.offtarget.dedup.bed";
    #####Create indel regions file
    $config{$sampleid}{'indel_intervals'} = "$base_dir$sampleid.indel.intervals";
    #####realign around indel regions
    $config{$sampleid}{'realigned_bamfile'} = "$base_dir$sampleid.realigned.bam";

    #####Covariate analysis before table recalibration
    $config{$sampleid}{'original_recalcsv_file'} = "$base_dir$sampleid.original.recal.csv";
    $config{$sampleid}{'covar_original_graphs_dir'} = "$base_dir"."$sampleid.covar_original/";
    unless (-d $config{$sampleid}{'covar_original_graphs_dir'}){
      mkdir $config{$sampleid}{'covar_original_graphs_dir'};
    }
    #####Covariate analysis after table recalibration
    $config{$sampleid}{'modified_recalcsv_file'} = "$base_dir$sampleid.modified.recal.csv";
    $config{$sampleid}{'covar_modified_graphs_dir'} = "$base_dir"."$sampleid.covar_modified/";
    unless (-d $config{$sampleid}{'covar_modified_graphs_dir'}){
      mkdir $config{$sampleid}{'covar_modified_graphs_dir'};
    }

    #####Recalibration of base calls
    $config{$sampleid}{'recal_grpfile'} = "$base_dir$sampleid.recal.grp";
    $config{$sampleid}{'recal_pdffile'} = "$base_dir$sampleid.recal.pdf";
    $config{$sampleid}{'recal_bamfile'} = "$base_dir$sampleid.recal.bam";
    ####Unified genotyper
    $config{$sampleid}{'primary_vcf_file'} = "$base_dir$sampleid.temp.vcf";
    $config{$sampleid}{'callmetrics_file'} = "$base_dir$sampleid.callmetrics.txt";
    ####tranche generations
    $config{$sampleid}{'vcfrecal_file'} = "$base_dir$sampleid.vcfrecal.txt";
    $config{$sampleid}{'vcfrecal_tranches_file'} = "$base_dir$sampleid.vcfrecal.tranches";
    ####recalibrate vcf calls
    $config{$sampleid}{'final_vcf_file'} = "$base_dir$sampleid.GATK.vcf";
    ####Coverage file
    $config{$sampleid}{'depthoftagsfile'} = "$base_dir$sampleid.coverage.txt";
  }
}

#####my $bwacommand = "qsub -b y -j yes -o $jobout -N N$sample.$i.aln -l virtual_free=$vfperthread,h_vmem=$hvperthread -pe threads $maxthreads 'bwa aln -n 10 -o 3 -e -1 -d 5 -l 21 -k 3 -t $maxthreads $reference ${$samples{$sample}}[$i] >$sai'";

my $reference = $malereference;
my ($jobid);

foreach my $sample (keys %config){

  #####set the reference to male or female here
#  my $reference = $femalereference;
#  if ($sample =~ /Sample_B/){
#    $reference = $malereference;
#    if ($sample =~ /Sample_B220/){
#      $reference = $femalereference;
#    }
#  }

  #####map both ends
  foreach my $fragmentend (keys %{$config{$sample}{'fastqfiles'}}){
    my $bwacommand = $timecommand;
#    $bwacommand = "qsub -b y -j y -o $config{$sample}{'processlog'} -N S$sample.$fragmentend.aln -l virtual_free=$vfperthread,h_vmem=$hvperthread -pe threads $maxthreads '$bwabin aln -n $maxthreads -l 21 -k 3 -t 6 -f $config{$sample}{'saifiles'}{$fragmentend} $reference $config{$sample}{'fastqfiles'}{$fragmentend}'";
    $jobid = `$bwacommand`;
    $jobid =~ /job (\d+) /;
    $config{$sample}{'bwa_aln_jobid'}{$fragmentend} = $1;
  }
  #####run sampe command, depends: bwa aln, output: raw bam file
  my @holdjid = (); ###bwa aln job ids
  my @saitag = (); ### sai files
  my @fastqtag = (); ### fastq files
  foreach my $fragmentend (sort keys %{$config{$sample}{'fastqfiles'}}){
    push (@holdjid, "$config{$sample}{'bwa_aln_jobid'}{$fragmentend}");
    push (@saitag, $config{$sample}{'saifiles'}{$fragmentend});
    push (@fastqtag, $config{$sample}{'fastqfiles'}{$fragmentend});
  }
  my $sampecommand = $timecommand;
#  $sampecommand = "qsub -b y -j y -hold_jid ".join(",", @holdjid)." -o $config{$sample}{'processlog'} -N S$sample.sampe -l virtual_free=$vfonethread,h_vmem=$hvperthread '$bwabin sampe -n 1 -N 1 -P -r \"$config{$sample}{'rgstring'}\" $reference ".join(" ", @saitag)." ".join(" ", @fastqtag)." | samtools view -bS1 -o $config{$sample}{'rawbamfile'} -'";
  $jobid = `$sampecommand`;
  $jobid =~ /job (\d+) /;
  $config{$sample}{'bwa_sampe_jobid'} = $1;

  
  #####run sort command
  my $bamsortcommand = $timecommand;
  my $bamsortmem = $maxgbmem/3*1024;
#  $bamsortcommand = "qsub -b y -j y -hold_jid $config{$sample}{'bwa_sampe_jobid'} -o $config{$sample}{'processlog'} -N S$sample.bamsort -l virtual_free=$vfonethread,h_vmem=$hvonethread '$bamtoolsbin sort -mem $bamsortmem -in $config{$sample}{'rawbamfile'} -out $config{$sample}{'rawsortedbamfile'}'";
  $jobid = `$bamsortcommand`;
  $jobid =~ /job (\d+) /;
  $config{$sample}{'bamsort_jobid'} = $1;

  
  ######run index command
  my $bamindexcommand = $timecommand;
#  $bamindexcommand = "qsub -b y -j y -hold_jid $config{$sample}{'bamsort_jobid'} -o $config{$sample}{'processlog'} -N S$sample.bamindex1 -l virtual_free=$vfonethread,h_vmem=$hvonethread 'samtools index $config{$sample}{'rawsortedbamfile'}'";
  $jobid = `$bamindexcommand`;
  $jobid =~ /job (\d+) /;
  $config{$sample}{'bamindex1_jobid'} = $1;

  
  ######bamstats before removing duplicates
  my $bamstatcommand = $timecommand;
#  $bamstatcommand = "qsub -b y -j y -hold_jid $config{$sample}{'bamindex1_jobid'} -o $config{$sample}{'processlog'} -N S$sample.bamstat1 -l virtual_free=$vfonethread,h_vmem=$hvonethread '$bamtoolsbin stats -in $config{$sample}{'rawsortedbamfile'} -insert'";
  $jobid = `$bamstatcommand`;
  $jobid =~ /job (\d+) /;
  $config{$sample}{'bamstats_jobid'} = $1;

  
  ######target coverage before removing duplicates
  my $targetcoveragecommand = $timecommand;
#  $targetcoveragecommand = "qsub -b y -j y -hold_jid $config{$sample}{'bamindex1_jobid'} -o $config{$sample}{'processlog'} -N S$sample.tgtcov1 -l virtual_free=$vfonethread,h_vmem=$hvonethread '$coverageBedbinary -abam -d -a $config{$sample}{'rawsortedbamfile'} -b $targetregions >$config{$sample}{'targetcoveragefile'}'";
  $jobid = `$targetcoveragecommand`;
  $jobid =~ /job (\d+) /;
  $config{$sample}{'targetcoverage_jobid'} = $1;

  
  ######offtarget coverage before removing duplicates
  my $offtargetcoveragecommand = $timecommand;
#  $offtargetcoveragecommand = "qsub -b y -j y -hold_jid $config{$sample}{'bamindex1_jobid'} -o $config{$sample}{'processlog'} -N S$sample.offtgtcov1 -l virtual_free=$vfonethread,h_vmem=$hvonethread '$coverageBedbinary -abam -d -a $config{$sample}{'rawsortedbamfile'} -b $offtargetregions >$config{$sample}{'offtargetcoveragefile'}'";
  $jobid = `$offtargetcoveragecommand`;
  $jobid =~ /job (\d+) /;
  $config{$sample}{'offtargetcoverage_jobid'} = $1;

  #####mark duplicates
  my $dedupcommand = $timecommand;
#  $dedupcommand = "qsub -b y -j y -hold_jid $config{$sample}{'bamstats_jobid'},$config{$sample}{'targetcoverage_jobid'},$config{$sample}{'offtargetcoverage_jobid'} -o $config{$sample}{'processlog'} -N S$sample.dedup -l virtual_free=$vfonethread,h_vmem=$hvonethread 'java -Xmx$javaonethread -jar $markdupbinary I=$config{$sample}{'rawsortedbamfile'} O=$config{$sample}{'dedupbamfile'} M=$config{$sample}{'dedupmetricsfile'}'";
  $jobid = `$dedupcommand`;
  $jobid =~ /job (\d+) /;
  $config{$sample}{'dedup_jobid'} = $1;
  ####create index on the dedup bam
  $bamindexcommand = $timecommand;
#  $bamindexcommand = "qsub -b y -j y -hold_jid $config{$sample}{'dedup_jobid'} -o $config{$sample}{'processlog'} -N S$sample.bamindex2 -l virtual_free=$vfonethread,h_vmem=$hvonethread '$bamtoolsbin index -in $config{$sample}{'dedupbamfile'}'";
  $jobid = `$bamindexcommand`;
  $jobid =~ /job (\d+) /;
  $config{$sample}{'bamindex2_jobid'} = $1;

  ######bamstats after rm duplicates
  $bamstatcommand = $timecommand;
#  $bamstatcommand = "qsub -b y -j y -hold_jid $config{$sample}{'bamindex2_jobid'} -o $config{$sample}{'processlog'} -N S$sample.bamstat2 -l virtual_free=$vfonethread,h_vmem=$hvonethread '$bamtoolsbin stats -in $config{$sample}{'dedupbamfile'} -insert'";
  $jobid = `$bamstatcommand`;
  $jobid =~ /job (\d+) /;
  $config{$sample}{'bamstats2_jobid'} = $1;

  
  ######target coverage after removing duplicates
  $targetcoveragecommand = $timecommand;
#  $targetcoveragecommand = "qsub -b y -j y -hold_jid $config{$sample}{'bamindex2_jobid'} -o $config{$sample}{'processlog'} -N S$sample.tgtcov2 -l virtual_free=$vfonethread,h_vmem=$hvonethread '$coverageBedbinary -abam -d -a $config{$sample}{'dedupbamfile'} -b $targetregions >$config{$sample}{'targetcoveragefilededup'}'";
  $jobid = `$targetcoveragecommand`;
  $jobid =~ /job (\d+) /;
  $config{$sample}{'targetcoverage2_jobid'} = $1;

  
  ######offtarget coverage after removing duplicates
  $offtargetcoveragecommand = $timecommand;
#  $offtargetcoveragecommand = "qsub -b y -j y -hold_jid $config{$sample}{'bamindex2_jobid'} -o $config{$sample}{'processlog'} -N S$sample.offtgtcov2 -l virtual_free=$vfonethread,h_vmem=$hvonethread '$coverageBedbinary -abam -d -a $config{$sample}{'dedupbamfile'} -b $offtargetregions >$config{$sample}{'offtargetcoveragefilededup'}'";
  $jobid = `$offtargetcoveragecommand`;
  $jobid =~ /job (\d+) /;
  $config{$sample}{'offtargetcoverage2_jobid'} = $1;

  #####identify indel regions
  my $realigntargetcommand = $timecommand;
#  $realigntargetcommand = "qsub -b y -j y -pe threads $maxthreads -hold_jid $config{$sample}{'bamindex2_jobid'},$config{$sample}{'targetcoverage2_jobid'},$config{$sample}{'offtargetcoverage2_jobid'} -o $config{$sample}{'processlog'} -N S$sample.realntarget -l virtual_free=$vfperthread,h_vmem=$hvperthread 'java -Xmx$javaperthread -jar $gatkbinary -T RealignerTargetCreator --known $gatkindelvcf --known $ncbidbsnpvcf --known $gatkhapmapvcf --known $gatkdbsnpvcf --known $gatkomnivcf -R $reference -I $config{$sample}{'dedupbamfile'} -o $config{$sample}{'indel_intervals'} -nt $maxthreads'";
  $jobid = `$realigntargetcommand`;
  $jobid =~ /job (\d+) /;
  $config{$sample}{'indeltarget_jobid'} = $1;
  #####realign indel regions
  my $indelrealigncommand = $timecommand;
#  $indelrealigncommand = "qsub -b y -j y -hold_jid $config{$sample}{'indeltarget_jobid'} -o $config{$sample}{'processlog'} -N S$sample.realn -l virtual_free=$vfonethread,h_vmem=$hvonethread 'java -Xmx$javaonethread -jar $gatkbinary -T IndelRealigner -R $reference -I $config{$sample}{'dedupbamfile'} -targetIntervals $config{$sample}{'indel_intervals'} -o $config{$sample}{'realigned_bamfile'}'";
  $jobid = `$indelrealigncommand`;
  $jobid =~ /job (\d+) /;
  $config{$sample}{'indelrealn_jobid'} = $1;

  ######GATK2 BaseRecalibrator
  my $baserecalcommand = $timecommand;
#  $baserecalcommand = "qsub -b y -j y -pe threads $maxthreads -hold_jid $config{$sample}{'indelrealn_jobid'} -o $config{$sample}{'processlog'} -N S$sample.baserecal -l virtual_free=$vfperthread,h_vmem=$hvperthread 'java -Xmx$javaonethread -jar $gatkbinary -T BaseRecalibrator -I $config{$sample}{'realigned_bamfile'} -R $reference -knownSites $gatkdbsnpvcf -knownSites $gatkindelvcf -knownSites $ncbidbsnpvcf -knownSites $gatkhapmapvcf -knownSites $gatkomnivcf --plot_pdf_file $config{$sample}{'recal_pdffile'} -o $config{$sample}{'recal_grpfile'} -nct $maxthreads'";
  $jobid = `$baserecalcommand`;
  $jobid =~ /job (\d+) /;
  $config{$sample}{'baserecal_jobid'} = $1;
  ######GATK2 PrintReads
  my $printreadscommand = $timecommand;
  $printreadscommand = "qsub -b y -j y -pe threads $maxthreads -hold_jid $config{$sample}{'baserecal_jobid'} -o $config{$sample}{'processlog'} -N S$sample.printreads -l virtual_free=$vfperthread,h_vmem=$hvperthread 'java -Xmx$javaonethread -Djava.io.tmpdir=$tmp_dir -jar $gatkbinary -T PrintReads -I $config{$sample}{'realigned_bamfile'} -o $config{$sample}{'recal_bamfile'} -R $reference -BQSR $config{$sample}{'recal_grpfile'} -nct $maxthreads'";
  $jobid = `$printreadscommand`;
  $jobid =~ /job (\d+) /;
  $config{$sample}{'printreads_jobid'} = $1;
  ######run unified genotyper
  my $unifiedgenotyper = $timecommand;
  $unifiedgenotyper = "qsub -b y -j y -pe threads $maxthreads -hold_jid $config{$sample}{'printreads_jobid'} -o $config{$sample}{'processlog'} -N S$sample.vcfcall -l virtual_free=$vfperthread,h_vmem=$hvperthread 'java -Xmx$javaonethread -Djava.io.tmpdir=$tmp_dir -jar $gatkbinary -T UnifiedGenotyper -R $reference -I $config{$sample}{'recal_bamfile'} --dbsnp $ncbidbsnpvcf --out $config{$sample}{'primary_vcf_file'} --genotype_likelihoods_model BOTH --metrics_file $config{$sample}{'callmetrics_file'} -nct $maxthreads'";
  $jobid = `$unifiedgenotyper`;
  $jobid =~ /job (\d+) /;
  $config{$sample}{'genotyper_jobid'} = $1;
  ######make tranche files from variant calls
  my $tranchegencommand = $timecommand;
  $tranchegencommand = "qsub -b y -j y -pe threads $maxthreads -hold_jid $config{$sample}{'genotyper_jobid'} -o $config{$sample}{'processlog'} -N S$sample.tranche -l virtual_free=$vfperthread,h_vmem=$hvperthread 'java -Xmx$javaperthread -Djava.io.tmpdir=$tmp_dir -jar $gatkbinary -T VariantRecalibrator -R $reference -input $config{$sample}{'primary_vcf_file'} -resource:hapmap,VCF,known=false,training=true,truth=true,prior=15.0 $gatkhapmapvcf -resource:omni,VCF,known=false,training=true,truth=false,prior=12.0 $gatkomnivcf -resource:dbsnp,VCF,known=true,training=false,truth=false,prior=6.0 $gatkdbsnpvcf -resource:mills,VCF,known=true,training=true,truth=true,prior=12.0 $gatkindelvcf -an QD -an HaplotypeScore -an MQRankSum -an ReadPosRankSum -an FS -an MQ -mode BOTH -recalFile $config{$sample}{'vcfrecal_file'} -tranchesFile $config{$sample}{'vcfrecal_tranches_file'} -nt $maxthreads'";
  $jobid = `$tranchegencommand`;
  $jobid =~ /job (\d+) /;
  $config{$sample}{'tranchegen_jobid'} = $1;
  ######recalibrate variant call
  my $vcfrecalcommand = $timecommand;
  $vcfrecalcommand = "qsub -b y -j y -pe threads $maxthreads -hold_jid $config{$sample}{'tranchegen_jobid'} -o $config{$sample}{'processlog'} -N S$sample.vcfrecal -l virtual_free=$vfperthread,h_vmem=$hvperthread 'java -Xmx$javaperthread -Djava.io.tmpdir=$tmp_dir -jar $gatkbinary -T ApplyRecalibration -R $reference -input $config{$sample}{'primary_vcf_file'} --ts_filter_level 99.0 -tranchesFile $config{$sample}{'vcfrecal_tranches_file'} -recalFile $config{$sample}{'vcfrecal_file'} -o $config{$sample}{'final_vcf_file'} -mode BOTH -nt $maxthreads'";
  $jobid = `$vcfrecalcommand`;
  $jobid =~ /job (\d+) /;
  $config{$sample}{'vcfrecal_jobid'} = $1;

  #####Run bamtools coverage (optional?)
  my $coveragecommand = $timecommand;
  $coveragecommand = "qsub -b y -j y -hold_jid $config{$sample}{'vcfrecal_jobid'} -o $config{$sample}{'processlog'} -N S$sample.dp -l virtual_free=$vfonethread,h_vmem=$hvperthread '$bamtoolsbin coverage -in $config{$sample}{'recal_bamfile'} | pigz - > $config{$sample}{'depthoftagsfile'}.gz'";
  $jobid = `$coveragecommand`;
  $jobid =~ /job (\d+) /;
  $config{$sample}{'bamcoverage_jobid'} = $1;

  ######run r script
  #my $rscriptcommand = "qsub -b y -j y -hold_jid $config{$sample}{'tranchegen_jobid'} -o $config{$sample}{'processlog'} -J $sample.rscript 'Rscript $config{$sample}{'rscript_file'}'";
  #$jobid = `$rscriptcommand`;
  #$jobid =~ /job (\d+) /;
  #$config{$sample}{'rscript_jobid'} = $1;
  
  #####cleanup
  #my $saifiles = join(" ", @saitag);
  #my $cleanupcommand = "qsub -b y -j y -hold_jid $config{$sample}{'vcffilter_jobid'} -o $config{$sample}{'processlog'} -J $sample.cleanup 'rm $saifiles $config{$sample}{'bwa_samfile'} $config{$sample}{'tempbamfile'} $config{$sample}{'tempbamfile'}.bai $config{$sample}{'indel_intervals'} $config{$sample}{'realigned_bamfile'} $config{$sample}{'realigned_bamfile'}.bai $config{$sample}{'recal_bamfile'} $config{$sample}{'recal_bamfile'}.bai'";
  #my $cleanupcommand = $timecommand;
  #$jobid = `$cleanupcommand`;
}

  ##for all samples at once
  my $printreads_jobids=join',',map{$config{$_}{'printreads_jobid'}} keys %config;
  my $recalbams=join' -I ',map{$config{$_}{'recal_bamfile'}} sort keys %config;
  my $sample='all';
    my $sampleid=$sample;
    $config{$sampleid}{'processlog'}= "$base_dir$sampleid.processlog"; ###get the sample id into config file
    ####Unified genotyper
    $config{$sampleid}{'primary_vcf_file'} = "$base_dir$sampleid.temp.vcf";
    $config{$sampleid}{'callmetrics_file'} = "$base_dir$sampleid.callmetrics.txt";
    ####tranche generations
    $config{$sampleid}{'vcfrecal_file'} = "$base_dir$sampleid.vcfrecal.txt";
    $config{$sampleid}{'vcfrecal_tranches_file'} = "$base_dir$sampleid.vcfrecal.tranches";
    ####recalibrate vcf calls
    $config{$sampleid}{'final_vcf_file'} = "$base_dir$sampleid.GATK.vcf";
  ######run unified genotyper
  my $unifiedgenotyper = $timecommand;
  $unifiedgenotyper = "qsub -b y -j y -pe threads $maxthreads -hold_jid $printreads_jobids -o $config{$sample}{'processlog'} -N S$sample.vcfcall -l virtual_free=$vfperthread,h_vmem=$hvperthread 'java -Xmx$javaonethread -Djava.io.tmpdir=$tmp_dir -jar $gatkbinary -T UnifiedGenotyper -R $reference -I $recalbams --dbsnp $ncbidbsnpvcf --out $config{$sample}{'primary_vcf_file'} --genotype_likelihoods_model BOTH --metrics_file $config{$sample}{'callmetrics_file'} -nct $maxthreads'";
  $jobid = `$unifiedgenotyper`;
  $jobid =~ /job (\d+) /;
  $config{$sample}{'genotyper_jobid'} = $1;
  ######make tranche files from variant calls
  my $tranchegencommand = $timecommand;
  $tranchegencommand = "qsub -b y -j y -pe threads $maxthreads -hold_jid $config{$sample}{'genotyper_jobid'} -o $config{$sample}{'processlog'} -N S$sample.tranche -l virtual_free=$vfperthread,h_vmem=$hvperthread 'java -Xmx$javaperthread -Djava.io.tmpdir=$tmp_dir -jar $gatkbinary -T VariantRecalibrator -R $reference -input $config{$sample}{'primary_vcf_file'} -resource:hapmap,VCF,known=false,training=true,truth=true,prior=15.0 $gatkhapmapvcf -resource:omni,VCF,known=false,training=true,truth=false,prior=12.0 $gatkomnivcf -resource:dbsnp,VCF,known=true,training=false,truth=false,prior=6.0 $gatkdbsnpvcf -resource:mills,VCF,known=true,training=true,truth=true,prior=12.0 $gatkindelvcf -an QD -an HaplotypeScore -an MQRankSum -an ReadPosRankSum -an FS -an MQ -mode BOTH -recalFile $config{$sample}{'vcfrecal_file'} -tranchesFile $config{$sample}{'vcfrecal_tranches_file'} -nt $maxthreads'";
  $jobid = `$tranchegencommand`;
  $jobid =~ /job (\d+) /;
  $config{$sample}{'tranchegen_jobid'} = $1;
  ######recalibrate variant call
  my $vcfrecalcommand = $timecommand;
  $vcfrecalcommand = "qsub -b y -j y -pe threads $maxthreads -hold_jid $config{$sample}{'tranchegen_jobid'} -o $config{$sample}{'processlog'} -N S$sample.vcfrecal -l virtual_free=$vfperthread,h_vmem=$hvperthread 'java -Xmx$javaperthread -Djava.io.tmpdir=$tmp_dir -jar $gatkbinary -T ApplyRecalibration -R $reference -input $config{$sample}{'primary_vcf_file'} --ts_filter_level 99.0 -tranchesFile $config{$sample}{'vcfrecal_tranches_file'} -recalFile $config{$sample}{'vcfrecal_file'} -o $config{$sample}{'final_vcf_file'} -mode BOTH -nt $maxthreads'";
  $jobid = `$vcfrecalcommand`;
  $jobid =~ /job (\d+) /;
  $config{$sample}{'vcfrecal_jobid'} = $1;

1;
