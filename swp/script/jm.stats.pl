use strict;

my $W1='/home/knam/work/sfrugi_Repro/simulation/swp/res_swp/vcf';
my $W2='/home/knam/work/sfrugi_Repro/simulation/swp/res_neu/vcf';

my $UD='/home/knam/work/sfrugi_Repro/simulation/swp/script/jstat';

opendir my $D,$W1;
my @F1=readdir($D);
close $D;

opendir my $D,$W2;
my @F2=readdir($D);
close $D;

my %FLs;
foreach my $f (@F1)
{
	if($f=~/(^.*)\.\d\.vcf.gz/)
	{
		my $Ff="$W1/$1";
		$FLs{$Ff}=1
	}
}
foreach my $f (@F2)
{
        if($f=~/(^.*)\.\d\.vcf.gz/)
        {
                my $Ff="$W2/$1";
                $FLs{$Ff}=1
        }
}

my @F=keys %FLs;

my $templ='#!/bin/bash

module load bioinfo/tabix-0.2.5
module load bioinfo/vcftools-0.1.16
module load system/R-3.6.2

export PERL5LIB=/usr/local/bioinfo/src/VCFtools/vcftools-0.1.16/src/perl
';


my $j=0;
foreach my $vcfF (@F)
{
	my $jb="$templ
perl /home/knam/work/sfrugi_Repro/simulation/swp/script/stats.pl $vcfF.0.vcf.gz
perl /home/knam/work/sfrugi_Repro/simulation/swp/script/stats.pl $vcfF.1.vcf.gz
perl /home/knam/work/sfrugi_Repro/simulation/swp/script/stats.pl $vcfF.2.vcf.gz
perl /home/knam/work/sfrugi_Repro/simulation/swp/script/stats.pl $vcfF.3.vcf.gz
perl /home/knam/work/sfrugi_Repro/simulation/swp/script/stats.pl $vcfF.4.vcf.gz
perl /home/knam/work/sfrugi_Repro/simulation/swp/script/stats.pl $vcfF.5.vcf.gz
perl /home/knam/work/sfrugi_Repro/simulation/swp/script/stats.pl $vcfF.6.vcf.gz
perl /home/knam/work/sfrugi_Repro/simulation/swp/script/stats.pl $vcfF.7.vcf.gz
perl /home/knam/work/sfrugi_Repro/simulation/swp/script/stats.pl $vcfF.8.vcf.gz

";
	open my $fd,">$UD/j$j";
	print $fd $jb;
	close $fd;

	print "sbatch j$j\n";
	$j++;

}
