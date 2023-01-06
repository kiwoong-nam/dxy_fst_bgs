use strict;

my $W1='/home/knam/work/sfrugi_Repro/simulation/swp/res_neu';
my $W2='/home/knam/work/sfrugi_Repro/simulation/swp/res_swp';

my $UD='/home/knam/work/sfrugi_Repro/simulation/swp/script/jvcf';

opendir my $D,$W1;
my @F1=readdir($D);
close $D;

opendir my $D,$W2;
my @F2=readdir($D);
close $D;

my @LIST;
foreach my $f (@F1)
{
	if($f=~/gz/) {push @LIST,"$W1/$f";}
}

foreach my $f (@F2)
{
        if($f=~/gz/) {push @LIST,"$W2/$f";}
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
perl /home/knam/work/sfrugi_Repro/simulation/swp/script/slimvcf2normalvcf.pl $vcfF

";
	open my $fd,">$UD/j$j";
	print $fd $jb;
	close $fd;

	print "sbatch j$j\n";
	$j++;

}
