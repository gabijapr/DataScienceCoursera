# Reading data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)

#6

VehicleSCC<-as.character(SCC$SCC[grep("vehicle", SCC$Short.Name, ignore.case=TRUE)])

VehicleB<- NEI %>% filter(fips=="24510", SCC %in% VehicleSCC) %>% 
        group_by(year) %>% mutate(County="Baltimore")

VehicleL<- NEI %>% filter(fips=="06037", SCC %in% VehicleSCC) %>% 
        group_by(year) %>% mutate(County="LA")

Both<- union(VehicleB, VehicleL)

Both$year<-as.factor(Both$year)
Both$County<-as.factor(Both$County)

ggplot(Both, aes(year, log10(Emissions), colour = County)) + geom_boxplot()+facet_grid(. ~ County)

dev.copy(png, file="plot6.png", width=680)
dev.off()