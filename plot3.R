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

## Extract Baltimore data
NEIBaltimore <- dplyr::filter(NEI, NEI$fips=="24510")

## Create Facets of Bar Plots
png("plot3.png")

library(ggplot2)
plot <- ggplot(data=NEIBaltimore, mapping=aes(x=year, y=Emissions))
plot + geom_bar(position="dodge", stat="sum") +
    facet_wrap(~type, ncol=2) +
    labs(x="Year",
        y="PM2.5 Emission (Tons)",
        title="Amount of PM2.5 Emission in Baltimore City",
        subtitle="By Four Types of Sources") +
    theme_bw() +
    theme(legend.position = "none") +
    scale_x_continuous(breaks=c(1999, 2002, 2005, 2008))
  
dev.off()