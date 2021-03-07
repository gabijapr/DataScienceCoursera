# Reading data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)

#2

baltimore<- NEI %>% filter(fips=="24510", year=="1999" | year == "2008") %>% 
        group_by(year) %>% summarize(sum=sum(Emissions))

barplot(baltimore$sum~baltimore$year, main="Total Baltimore PM2.5 Emissions", xlab="Year",
        ylab ="Emissions", col="red")

dev.copy(png, file="plot2.png")
dev.off()