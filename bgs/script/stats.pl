use strict;

my $popD='/home/knam/work/sfrugi_Repro/simulation/bgs/stats/pop';
my $statD='/home/knam/work/sfrugi_Repro/simulation/bgs/stats';

my $input=shift;
$input=~/res_(\w+)\/vcf\/(.*)\.(\d+)\.vcf/;
my $cate=$1;
my $id=$2;
my $time=$3;

my $output="$statD/stat.$cate.$id.$time";
print "$cate $id $time";

#/home/knam/work/sfrugi_Repro/simulation_dxy/res_swp/vcf/m.A10646.0.vcf.gz

my $res;#="cate\tid\ttime\tpos\tfst\tnSNP\tdxy\n";

`vcftools --gzvcf $input --weir-fst-pop $popD/p1 --weir-fst-pop $popD/p2 --fst-window-size 2000000 --fst-window-step 2000000 --out $statD/$cate.$id.$time`;

`vcftools --gzvcf $input --keep $popD/p1 --window-pi 2000000 --out $statD/$cate.$id.$time`;

`python3 /home/knam/save/programs/Dxy-master/Dxy_calculate -v $input -p $popD/pops -w 2000000 -s 2000000 -o $statD/$cate.$id.$time.dxy`;

my @dxy;
open my $fd,"$statD/$cate.$id.$time.dxy";
while(<$fd>)
{
	$_=~s/\n//;
	my @s=split("\t",$_);
	push @dxy,$s[4];
}
close $fd;

my @pi;
open my $fd,"$statD/$cate.$id.$time.windowed.pi";
while(<$fd>)
{
        $_=~s/\n//;
        my @s=split("\t",$_);
	push @pi,$s[4];
}
close $fd;

open my $fd,"$statD/$cate.$id.$time.windowed.weir.fst";
my @fsts=<$fd>;
close $fd;

for(my $i=1;$i<=$#fsts;$i++)
{
	my @fst=split("\t",$fsts[$i]);
	my $p=$fst[1]+10000-1;
	$res.="$cate\t$id\t$time\t$p\t$fst[4]\t$pi[$i]\t$dxy[$i]\n";
}

open my $fd,">$output";
print $fd $res;
close $fd;

`rm $statD/$cate.$id.$time.dxy`;
`rm $statD/$cate.$id.$time.windowed.weir.fst`;
`rm $statD/$cate.$id.$time.windowed.pi`;
`rm $statD/$cate.$id.$time.log`;
