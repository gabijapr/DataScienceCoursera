## 1 

FileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(FileUrl, destfile="data.csv")

data<-read.csv("data.csv")

agricultureLogical<-data$ACR==3&data$AGS==6

which(agricultureLogical)[1:3]

## 2 

library(jpeg)
        
data2<-readJPEG("thing.jpg", native=TRUE)

quantile(data2, probs=c(0.3,0.8))

## 3 klausimas

FileUrl2<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
FileUrl3<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(FileUrl2, destfile="du.csv")
download.file(FileUrl3, destfile="trys.csv")

gpd<-read.csv("du.csv", skip=4)
ed<-read.csv("trys.csv")

mergedData=merge(gpd,ed, by.x="X", by.y="CountryCode")
nrow(mergedData)

mergedData[order(mergedData$X.1, decreasing=TRUE),][13,"X"]

## 4 

library(dplyr)
ketv=filter(mergedData, Income.Group=="High income: OECD")
a<-ketv[,2][ketv[,2]!=""]
mean(as.integer(a))

penkt=filter(mergedData, Income.Group=="High income: nonOECD")
b<-penkt[,2][penkt[,2]!=""]
mean(as.integer(b))

# 5 

abc<-mergedData[order(mergedData$X.1),]
def<-abc[1:38,]
ghi=filter(def, Income.Group=="Lower middle income")





