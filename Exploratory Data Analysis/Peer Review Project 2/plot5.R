# Reading data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)

#5

VehicleSCC<-as.character(SCC$SCC[grep("vehicle", SCC$Short.Name, ignore.case=TRUE)])

VehicleB<- NEI %>% filter(fips=="24510", SCC %in% VehicleSCC) %>% 
        group_by(year) %>% summarize(sum=sum(Emissions))

barplot(VehicleB$sum~VehicleB$year, main="Total Vehicle Emissions By Year In Baltimore", 
        xlab="Year", ylab ="Emissions", col="black")

dev.copy(png, file="plot5.png")
dev.off()
