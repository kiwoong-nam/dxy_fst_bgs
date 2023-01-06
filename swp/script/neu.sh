#!/bin/bash

module load bioinfo/tabix-0.2.5
module load bioinfo/vcftools-0.1.16
module load system/R-3.6.2

export PERL5LIB=/usr/local/bioinfo/src/VCFtools/vcftools-0.1.16/src/perl

R=$RANDOM

cd /home/knam/work/sfrugi_Repro/simulation/swp/res_neu

/home/knam/save/programs/SLiM4/SLiM/build/slim /home/knam/work/sfrugi_Repro/simulation_dxy/input/neu | gzip -f > r.A$R.gz


