# Reading data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)

#4

coalSCC<-as.character(SCC$SCC[grep("Coal", SCC$Short.Name)])

coalEmissions<- NEI %>% filter(SCC %in% coalSCC) %>% 
        group_by(year) %>% summarize(sum=sum(Emissions))

barplot(coalEmissions$sum~coalEmissions$year, main="Total Coal Emissions By Year", xlab="Year",
        ylab ="Emissions", col="green")


dev.copy(png, file="plot4.png")
dev.off()