setwd("~/Hospy")
outcomee<-read.csv("outcome-of-care-measures.csv", colClasses="character")

outcomee[, 11] <- as.numeric(outcome[, 11]) 
hist(outcomee[, 11])

best<-function(state, outcome){
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character", header=TRUE)
        data2 <- as.data.frame(cbind(data[, 2],   # hospital
                                    data[, 7],   # state
                                    data[, 11],  # heart attack
                                    data[, 17],  # heart failure
                                    data[, 23]), # pneumonia
                              stringsAsFactors = FALSE)
        colnames(data2) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
        
        ## Check that state and outcome are valid
        if(!state %in% data2[, "state"]){
                stop('invalid state')
        } else if(!outcome %in% c("heart attack", "heart failure", "pneumonia")){
                stop('invalid outcome')
        } else {
                si <- which(data2[, "state"] == state)
                ts <- data2[si, ]    # extracting data for the called state
                oi <- as.numeric(ts[, eval(outcome)])
                min_val <- min(oi, na.rm = TRUE)
                result  <- ts[, "hospital"][which(oi == min_val)]
                output  <- result[order(result)]
        }
        return(output)
}

rankhospital <- function(state, outcome, num = "best")
{
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character", header=TRUE)
        data2 <- as.data.frame(cbind(data[, 2],   # hospital
                                     data[, 7],   # state
                                     data[, 11],  # heart attack
                                     data[, 17],  # heart failure
                                     data[, 23]), # pneumonia
                               stringsAsFactors = FALSE)
        colnames(data2) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
        
        ## Check that state and outcome are valid
        if(!state %in% data2[, "state"])
        {
                stop('invalid state')
        } 
        else if(!outcome %in% c("heart attack", "heart failure", "pneumonia"))
        {
                stop('invalid outcome')
        } 
        else if(class(num)=="numeric" && num>length(data2$hospital))
        {
                stop("NA")
        }
                 
        else
        {
                if (num=="best")
                {
                        num<-1
                        si <- which(data2[, "state"] == state)
                        ts <- data2[si, ]    # extracting data for the called state
                        oi <- as.numeric(ts[, eval(outcome)])
                        orderig<-sort(oi)
                        result<-ts[,"hospital"][which(orderig[num]==ts[,outcome])]
                        output  <- result[order(result, decreasing=FALSE)]
                        return (output[1])
                }
                if (num=="worst")
                {
                        num<-1
                        si <- which(data2[, "state"] == state)
                        ts <- data2[si, ]    # extracting data for the called state
                        oi <- as.numeric(ts[, eval(outcome)])
                        orderig<-sort(oi)
                        result<-ts[,"hospital"][which(orderig[num]==ts[,outcome])]
                        output  <- result[order(result, decreasing=TRUE)]
                        return (output[1])
                }
                
                si <- which(data2[, "state"] == state)
                ts <- data2[si, ]    # extracting data for the called state
                oi <- as.numeric(ts[, eval(outcome)])
                orderig<-sort(oi)
                result<-ts[,"hospital"][which(orderig[num]==ts[,outcome])]
                output  <- result[order(result, decreasing=FALSE)]
                return (output[1])
        }
}

rankall <- function(outcome, num = "best")
{
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character", header=TRUE)
        data2 <- as.data.frame(cbind(data[, 2],   # hospital
                                     data[, 7],   # state
                                     data[, 11],  # heart attack
                                     data[, 17],  # heart failure
                                     data[, 23]), # pneumonia
                               stringsAsFactors = FALSE)
        colnames(data2) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
        
        
        allex<-factor(data2$state)
        lvl<-levels(allex)
        rezhos<-vector(mode="character",length=length(lvl))
        rezstate<-vector(mode="character",length=length(lvl))
        
        if(class(num)=="numeric" && num>length(data2$hospital))
        {
                print(NA)
        }
        
        else
        {
                for(i in seq_along(lvl))
                {
                        
                        state<-lvl[i]
                        rezstate[i]<-state
                        
                        if (num=="best")
                        {
                                num<-1
                                si <- which(data2[, "state"] == state)
                                ts <- data2[si, ]    # extracting data for the called state
                                oi <- as.numeric(ts[, eval(outcome)])
                                orderig<-sort(oi)
                                result<-ts[,"hospital"][which(orderig[num]==ts[,outcome])]
                                output  <- result[order(result, decreasing=FALSE)]
                                rezhos[i]<-output[1]
                                
                        }
                        if (num=="worst")
                        {
                                num<-1
                                si <- which(data2[, "state"] == state)
                                ts <- data2[si, ]    # extracting data for the called state
                                oi <- as.numeric(ts[, eval(outcome)])
                                orderig<-sort(oi, decreasing=TRUE, na.last=TRUE)
                                result<-ts[,"hospital"][which(orderig[num]==ts[,outcome])]
                                output  <- result[order(result, decreasing=TRUE)]
                                
                                rezhos[i]<-output[1]
                                
                        }
                        
                        si <- which(data2[, "state"] == state)
                        ts <- data2[si, ]    # extracting data for the called state
                        oi <- as.numeric(ts[, eval(outcome)])
                        orderig<-sort(oi, decreasing=FALSE, na.last=TRUE)
                        result<-ts[,"hospital"][which(orderig[num]==ts[,outcome])]
                        output  <- result[order(result, decreasing=FALSE, na.last=TRUE)]
                        rezhos[i]<-output[1]
                        
                        
                }
        }
        return(as.data.frame(cbind(rezhos,rezstate)))
}
