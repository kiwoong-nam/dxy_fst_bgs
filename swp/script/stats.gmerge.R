v=read.table('/home/knam/work/sfrugi_Repro/simulation/swp/merged.txt',fill=TRUE)
vs=subset(v,V5 > -100 & V7 > -100)

vg=aggregate(vs[c(5,6,7)],by=list(vs$V1,vs$V3,vs$V4),mean)

colnames(vg)=c("category","time","position","Fst","pi","Dxy")

vg$T=NA
vg$T[vg$time==0]=20
vg$T[vg$time==1]=40
vg$T[vg$time==2]=60
vg$T[vg$time==3]=80
vg$T[vg$time==4]=100
vg$T[vg$time==5]=200
vg$T[vg$time==6]=300
vg$T[vg$time==7]=400
vg$T[vg$time==8]=500

write.table(vg,"/home/knam/work/sfrugi_Repro/simulation/swp/gmerged.txt",sep="\t",quote=F,row.names=F)

