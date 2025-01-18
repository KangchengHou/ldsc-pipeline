baseline = NULL
MAF      = NULL
for (chr in 1:22){
	data <- read.table(gzfile(paste("baseline.",chr,".annot.gz",sep="")), header=T)
	baseline=rbind(baseline,data[,-(1:4)])
    temp=read.table(paste("../plink_files/1000G.EUR.QC.",chr,".frq",sep=""),h=T)
	MAF=c(MAF,temp$MAF)
}

rare = which(MAF<0.05)

#ANALYSE 2: Sd
sdout = apply(baseline[-rare,],2,sd)
write.table(cbind(names(sdout),sdout),file="sd.txt",quote=F,sep="\t",col.names=F,row.names=F)
