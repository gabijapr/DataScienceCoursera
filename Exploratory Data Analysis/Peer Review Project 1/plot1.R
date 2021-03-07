library(dplyr)

#data reading

data<-read.table("household_power_consumption.txt", header=TRUE, na.strings="?", 
                 sep=";") %>% filter(Date == "1/2/2007" | Date == "2/2/2007")

#1

hist(data$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")

dev.copy(png, file="plot1.png")
dev.off()