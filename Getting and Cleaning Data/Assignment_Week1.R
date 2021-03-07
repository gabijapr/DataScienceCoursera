# data.csv is from https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# code book https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
data<-read.csv("data.csv")

navalue<-data$VAL
value<-na.omit(navalue)

a<-0
for (i in seq_along(value))
{
        if (value[i]==24) a<-a+1
        a
}

# data2 is from https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx 

library(openxlsx)
dat<-read.xlsx("data2.xlsx", colNames=TRUE, startRow=18)
sum(dat$Zip*dat$Ext,na.rm=T)

library(XML)
library(RCurl)

fileUrl3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"

xData <- getURL(fileUrl3) ##the getURL() of Rcurl helps fetch the https ##URL which can be then parsed by xml

data3 <- xmlTreeParse(xData,useInternal = TRUE)

rootNode <- xmlRoot(data3)

b<-0
zip<-xpathSApply(rootNode,"//zipcode",xmlValue)
for(i in seq_along(zip))
{
        if(zip[i]==21231) b<-b+1
}

fileUrl4<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url, destfile="C:/Users/gabij/Desktop/data4.csv")