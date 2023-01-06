use strict;

my $fileN=shift;
$fileN=~/(^.*res.*)\/(.*$)/;
my $Wdir=$1;
my $inputF=$2;

unless($inputF=~/^r\.(.*)\.gz/) {next}
my $input=$1;

my $temp1="$Wdir/$input/1.vcf";
my $temp2="$Wdir/$input/2.vcf";

`mkdir $Wdir/$input`;

my @d;
open my $fd,"zcat $Wdir/$inputF | ";
while(<$fd>) {push @d,$_}
close $fd;

for(my $j=0;$j<7;$j++) {shift @d}

my @vcf;
for(my $i=0;$i<22;$i++){push @vcf,''}
my $tg=-1;
L:foreach my $line (@d)
{
	if($line=~/OUT/)
	{
		$tg++;
		next;
	}
	$vcf[$tg].=$line;
}

for(my $i=0;$i<1;$i+=2)
{
	open my $fd,">$temp1";
	print $fd $vcf[$i];
	close $fd;

	open my $fd,">$temp2";
	print $fd $vcf[$i+1];
	close $fd;

	`bgzip -f $temp1`;
	`bgzip -f $temp2`;

	`tabix -p vcf $temp1.gz`;
	`tabix -p vcf $temp2.gz`;

	my $k=$i/2;
	`vcf-merge  $temp1.gz $temp2.gz > $Wdir/vcf/n.$input.$k.vcf`;

	`rm $temp1*`;
	`rm $temp2*`;

	my $newvcffile;
	open my $fd,"$Wdir/vcf/n.$input.$k.vcf"; 
	while(<$fd>)
	{
		if($_=~/#/){$newvcffile.=$_}
		else
		{
			$_=~s/\n//g;
			my @s=split("\t",$_);
			my @newline;
			for(my $i=0;$i<10;$i++)
			{
				my $l=shift @s;
				push @newline,$l;
			}
			foreach my $l (@s)
			{
				if($l =~/\./) {push @newline,'0/0'}
				else
				{
					$l=~s/\|/\//;
					push @newline,$l;
				}
			}
			my $nw=join("\t",@newline);
			$nw.="\n";
			$newvcffile.=$nw;
		}
	}	

	my $newN="$Wdir/vcf/m.$input.$k.vcf";
	$newN=~s/gz/vcf/;

	open my $fd,">$newN";
	print $fd $newvcffile;
	close $fd;

	`rm $Wdir/vcf/n.$input.$k.vcf`; 
	`gzip -f $newN`;
}

`rm -rf $Wdir/$input`;
