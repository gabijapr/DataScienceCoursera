# Reading data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)

#1

#summary table
sum<- NEI %>% group_by(year) %>% summarize(sum=sum(Emissions))

barplot(sum$sum~sum$year, main="Total Emissions By Year", xlab="Year",
        ylab ="Emissions", col="Cyan", space=0.5)

#2

baltimore<- NEI %>% filter(fips=="24510", year=="1999" | year == "2008") %>% 
        group_by(year) %>% summarize(sum=sum(Emissions))

barplot(baltimore$sum~baltimore$year, main="Total Baltimore PM2.5 Emissions", xlab="Year",
        ylab ="Emissions", col="red")

#3
library (ggplot2)

baltimore<- NEI %>% filter(fips=="24510") %>% 
        select(c("Emissions", "type", "year")) %>% group_by(year)

baltimore$year<-as.factor(baltimore$year)

ggplot(baltimore, mapping = aes(year, log10(Emissions),colour=year, 
        fill=year)) + 
        geom_boxplot(alpha=0.2) + 
        labs(title="Changes in Emissions in Baltimore By Type") +
        facet_grid(. ~ type)
#4

coalSCC<-as.character(SCC$SCC[grep("Coal", SCC$Short.Name)])

coalEmissions<- NEI %>% filter(SCC %in% coalSCC) %>% 
        group_by(year) %>% summarize(sum=sum(Emissions))

barplot(coalEmissions$sum~coalEmissions$year, main="Total Coal Emissions By Year", xlab="Year",
        ylab ="Emissions", col="green")


#5

VehicleSCC<-as.character(SCC$SCC[grep("vehicle", SCC$Short.Name, ignore.case=TRUE)])

VehicleB<- NEI %>% filter(fips=="24510", SCC %in% VehicleSCC) %>% 
        group_by(year) %>% summarize(sum=sum(Emissions))

barplot(VehicleB$sum~VehicleB$year, main="Total Vehicle Emissions By Year In Baltimore", 
        xlab="Year", ylab ="Emissions", col="black")

#6

VehicleB<- NEI %>% filter(fips=="24510", SCC %in% VehicleSCC) %>% 
        group_by(year) %>% mutate(County="Baltimore")

VehicleL<- NEI %>% filter(fips=="06037", SCC %in% VehicleSCC) %>% 
        group_by(year) %>% mutate(County="LA")

Both<- union(VehicleB, VehicleL)

Both$year<-as.factor(Both$year)
Both$County<-as.factor(Both$County)

ggplot(Both, aes(year, log10(Emissions), colour = County)) + geom_boxplot()+facet_grid(. ~ County)

