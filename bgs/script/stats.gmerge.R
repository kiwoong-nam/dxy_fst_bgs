v=read.table('/home/kiwoong/Projects/sfrugi_Repro/simulation/bgs/merged.txt',fill=TRUE)
vs=subset(v,V5 > -100 & V7 > -100)

vg=aggregate(vs[c(5,6,7)],by=list(vs$V1),mean)

colnames(vg)=c("category","Fst","pi","Dxy")

vg$R=c(1.19e-6,1.19e-7,1.19e-8,1.19e-9,1.19e-10,NA)

write.table(vg,"/home/kiwoong/Projects/sfrugi_Repro/simulation/bgs/gmerged.txt",sep="\t",quote=F,row.names=F)


