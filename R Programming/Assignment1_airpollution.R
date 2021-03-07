
pollutantmean <- function(directory, pollutant, id=1:332)
{
        averagesum<-0

        for (i in id)
        {
                number<-sprintf("%03d",i)
                loc<-paste(directory,number,sep="/")
                syesvy<-"csv"
                location<-paste(loc,syesvy,sep=".")
                
                a<-read.csv(file=location, header=TRUE)
                b<-sum(a[,pollutant], na.rm=TRUE)
                c<-length(na.omit(a[,pollutant]))
                new<-b/c
                averagesum<-averagesum+new                                  
        }
        averagesum/length(id)
}

complete<- function(directory, id=1:332)
{
        a=1
        nobs <- vector(mode="integer", length=length(id))
        
        for(i in id)
        {
                number<-sprintf("%03d",i)
                loc<-paste(directory,number,sep="/")
                syesvy<-"csv"
                location<-paste(loc,syesvy,sep=".")

                dataa<-read.csv(file=location, header=TRUE)

                nobs[a] <- sum(complete.cases(dataa))
                
                frame<-data.frame(id, nobs)
                a<-a+1
        }
        frame
}

corr <- function(directory, threshold=0){
        
        id=1:332  
        num=0
        cases<-complete(directory)

        vec<-vector("numeric",length=num)
        a=1
        
        for(i in id)
        {
                number<-sprintf("%03d",i)
                loc<-paste(directory,number,sep="/")
                syesvy<-"csv"
                location<-paste(loc,syesvy,sep=".")
        
                dataa<-read.csv(file=location, header=TRUE)
                
                nobs <- sum(complete.cases(dataa))
                if(nobs>threshold)
                {
                        thing<-cor(dataa[,c("nitrate","sulfate")], use="complete.obs")
                        vec[a]<-thing[1,2]
                        a<-a+1
                        
                }

        }
        vec[vec!=0]
}

