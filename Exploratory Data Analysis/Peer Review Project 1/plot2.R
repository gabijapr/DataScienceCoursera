library(dplyr)

#data reading

data<-read.table("household_power_consumption.txt", header=TRUE, na.strings="?", 
                 sep=";") %>% filter(Date == "1/2/2007" | Date == "2/2/2007")

data<-mutate(data, within(data, { Time = strptime(paste(Date, Time), 
                                                  "%d/%m/%Y%H:%M:%S") }))

data<-mutate(data2, Date = as.Date(Date, format="%d/%m/%y"))


#2
plot(data$Time,data$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")

dev.copy(png, file="plot2.png")
dev.off()




