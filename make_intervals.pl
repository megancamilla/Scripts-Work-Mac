#!/usr/bin/perl

#usage: perl script.pl fasta.index intervalsize output.bed
#generate regular intervals in bed format for bedtools comparisons

open(IN, '<', @ARGV[0]);
open(OUT, '>', @ARGV[2]);
%hash = undef;
$n = 0;
while (<IN>) {
	$line = $_;
	chomp $line;
	unless ($line eq undef) {
		@data = split(/\t/, $line);

		$go = 1;
		$i = 1;
		while ($go == 1) {
			$n++;
			print OUT "@data[0]\t$i\t";
			if (($i + @ARGV[1]) >= @data[1]) {
				$i = @data[1];
			}
			else {
				$i += @ARGV[1];
			}
			print OUT "$i\tinterval_$n\n";
			if ($i == @data[1]) {
				$go = 0;
				last;
			}
		}


	}
}


