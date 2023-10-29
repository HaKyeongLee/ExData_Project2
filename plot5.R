## Download and Unzip the Data Files
setwd("~/ExData_Project2")
fileUrl <- ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip")
download.file(fileUrl, "FNEI.zip")
unzip("FNEI.zip")

## Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
table(NEI$year)   # There are only 1999, 2002, 2005, 2008 data.
                  # No need to extract any column.

## Extract Vehicle related Baltimore data
SCCVehicle <- SCC[grepl("[Vv]ehicle", SCC$SCC.Level.Two, ignore.case=TRUE), ]
NEIVehicle <- NEI[NEI$SCC %in% SCCVehicle$SCC,]
NEIBaltimoreOR <- NEIVehicle[NEIVehicle$fips=="24510", ]

## Aggregate NEIBaltimoreOR data
AggNEIBaltimoreOR <- aggregate(Emissions ~ year, NEIBaltimoreOR, sum)

## Create a Bar Plot
png("plot5.png")

library(ggplot2)
plot <- ggplot(data=AggNEIBaltimoreOR, mapping=aes(x=factor(year), y=Emissions))
plot + geom_bar(position="dodge", stat="identity") +
    labs(x="Year",
         y="PM2.5 Emission (Tons)",
         title="Amount of PM2.5 Emissions in the Baltimore City",
         subtitle="From Motor Vehicle Sources") +
    theme_bw() +
    scale_size(guide="none")
dev.off()
