use strict;

my $W='/home/knam/work/sfrugi_Repro/simulation/bgs/res_';
my $UD='/home/knam/work/sfrugi_Repro/simulation/bgs/script/jvcf';

my @as=('bgs1','bgs2','bgs3','bgs4','bgs5','neu');
my @LIST;

foreach my $a (@as)
{
	my $WD="$W$a";

	opendir my $D,$WD;
	my @F=readdir($D);
	close $D;

	foreach my $f (@F)
	{
		if($f=~/gz/) {push @LIST,"$WD/$f";}
	}
}

my $templ='#!/bin/bash

module load bioinfo/tabix-0.2.5
module load bioinfo/vcftools-0.1.16
module load system/R-3.6.2

export PERL5LIB=/usr/local/bioinfo/src/VCFtools/vcftools-0.1.16/src/perl
';


my $j=0;
foreach my $vcfF (@LIST)
{
	my $jb="$templ
perl /home/knam/work/sfrugi_Repro/simulation/bgs/script/slimvcf2normalvcf.pl $vcfF

";
	open my $fd,">$UD/j$j";
	print $fd $jb;
	close $fd;

	print "sbatch j$j\n";
	$j++;

}
