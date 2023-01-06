#!/bin/bash

module load bioinfo/tabix-0.2.5
module load bioinfo/vcftools-0.1.16
module load system/R-3.6.2

export PERL5LIB=/usr/local/bioinfo/src/VCFtools/vcftools-0.1.16/src/perl

R=$RANDOM

cd /home/knam/work/sfrugi_Repro/simulation/bgs/

/home/knam/save/programs/SLiM4/SLiM/build/slim input/bgs1 | gzip -f > res_bgs1/r.A$R.gz
/home/knam/save/programs/SLiM4/SLiM/build/slim input/bgs2 | gzip -f > res_bgs2/r.A$R.gz
/home/knam/save/programs/SLiM4/SLiM/build/slim input/bgs3 | gzip -f > res_bgs3/r.A$R.gz
/home/knam/save/programs/SLiM4/SLiM/build/slim input/bgs4 | gzip -f > res_bgs4/r.A$R.gz
/home/knam/save/programs/SLiM4/SLiM/build/slim input/bgs5 | gzip -f > res_bgs5/r.A$R.gz
/home/knam/save/programs/SLiM4/SLiM/build/slim input/neu | gzip -f > res_neu/r.A$R.gz


