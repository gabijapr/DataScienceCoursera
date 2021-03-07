library(dplyr)

#data reading

data<-read.table("household_power_consumption.txt", header=TRUE, na.strings="?", 
                 sep=";") %>% filter(Date == "1/2/2007" | Date == "2/2/2007")

data<-mutate(data, within(data, { Time = strptime(paste(Date, Time), 
                                                  "%d/%m/%Y%H:%M:%S") }))

data<-mutate(data2, Date = as.Date(Date, format="%d/%m/%y"))

#3
dev.off()
with(data, plot(Time, Sub_metering_1, type="l", xlab="",
                ylab="Energy sub metering", col="black"))

with(data, lines (Time, Sub_metering_2, col="red"))

with(data, lines (Time, Sub_metering_3, col="blue"))

par(mar=c(1,1,0.5,0.05))
legend("topright", legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col=c("black", "blue", "red"),lwd=1,lty=1)

dev.copy(png, file="plot3.png")
dev.off()




