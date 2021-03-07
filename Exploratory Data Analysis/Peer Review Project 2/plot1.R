# Reading data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)

#1

#table gives the year and the sum of emissions
sum<- NEI %>% group_by(year) %>% summarize(sum=sum(Emissions))

barplot(sum$sum~sum$year, main="Total Emissions By Year", xlab="Year",
        ylab ="Emissions", col="Cyan", space=0.5)

dev.copy(png, file="plot1.png")
dev.off()
