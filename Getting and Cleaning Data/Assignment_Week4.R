# 1 
File<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(File, destfile="data.csv")

data<-read.csv("data.csv")

colnames(data)

a<-strsplit(colnames(data), "wgtp")
a[123]

# 2 

File2<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"

download.file(File2, destfile="data2.csv")

data2<-read.csv("data2.csv", skip=4)
b<-as.character(data2$X.4, na.rm=TRUE)
c<-sub(",","",b)
d<-as.numeric(sub(",","",c))
e<-na.omit(d)
2*mean(e[1:204])

# 3

grep("^United", data2$X)

# 4 

# 5 
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

year<-as.numeric(format(sampleTimes, '%Y'))
length(year[which(year[]==2012)])

