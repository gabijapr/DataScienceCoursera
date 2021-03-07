library(dplyr)

#data reading

data<-read.table("household_power_consumption.txt", header=TRUE, na.strings="?", 
                 sep=";") %>% filter(Date == "1/2/2007" | Date == "2/2/2007")

data<-mutate(data, within(data, { Time = strptime(paste(Date, Time), 
                                                  "%d/%m/%Y%H:%M:%S") }))

data<-mutate(data2, Date = as.Date(Date, format="%d/%m/%y"))


#4
par(mfrow=c(2,2), mar=c(4,4,1,1))

with(data, plot(Time, Global_active_power, type="l", xlab="", ylab="Global Active Power"))

with(data, plot(Time, Voltage,type="l", xlab="datetime",ylab="Voltage"))

with(data, plot(Time, Sub_metering_1, type="l", xlab="",
                ylab="Energy sub metering", col="black"))
with(data, lines (Time, Sub_metering_2, col="red"))
with(data, lines (Time, Sub_metering_3, col="blue"))

legend("topright", legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col=c("black", "blue", "red"),lwd=1,lty=1, cex=0.4)

with(data, plot(Time, Global_reactive_power, type="l", xlab="datetime"))

dev.copy(png, file="plot4.png")
dev.off()



