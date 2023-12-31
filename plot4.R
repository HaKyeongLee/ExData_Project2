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

## Extract coal-combustion relevant observations from SCC and NEI 
head(SCC, n=10)
head(NEI, n=10)
SCCcoal <- SCC[grepl("coal", SCC$Short.Name, ignore.case = T),]
NEIcoal <- NEI[NEI$SCC %in% SCCcoal$SCC,]

## Aggregate NEIcoal Data
AggNEIcoal <- aggregate(Emissions ~ year, NEIcoal, sum)

## Rescale Emissions to Thousand Tons
AggNEIcoal$Emissions <- AggNEIcoal$Emissions/1000

## Create a bar plot
png("plot4.png")

library(ggplot2)
plot <- ggplot(data=AggNEIcoal, mapping=aes(x=factor(year), y=Emissions))
plot + geom_bar(position="dodge", stat="identity") +
    labs(x="Year",
         y="PM2.5 Emission (Thousand Tons)",
         title="Amount of PM2.5 Emissions in the U.S.",
         subtitle="From Coal-Combustion Sources") +
    theme_bw() +
    scale_size(guide="none")
dev.off()