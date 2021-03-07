# Reading data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library (ggplot2)

#3 

baltimore<- NEI %>% filter(fips=="24510") %>% 
        select(c("Emissions", "type", "year")) %>% group_by(year)

baltimore$year<-as.factor(baltimore$year)

ggplot(baltimore, mapping = aes(year, log10(Emissions),colour=year, 
                                fill=year)) + 
        geom_boxplot(alpha=0.2) + 
        labs(title="Changes in Emissions in Baltimore By Type") +
        facet_grid(. ~ type)

dev.copy(png, file="plot3.png", width=780)
dev.off()