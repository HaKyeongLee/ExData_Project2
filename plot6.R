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

## Extract Baltimore City and Los Angeles County Vehicle related data
SCCVehicle <- SCC[grepl("[Vv]ehicle", SCC$SCC.Level.Two, ignore.case=TRUE), ]
NEIVehicle <- NEI[NEI$SCC %in% SCCVehicle$SCC,]
NEI_BC_LA <- NEIVehicle[NEIVehicle$fips=="24510" | NEIVehicle$fips=="06037", ]

## Replace fips code with the region name
NEI_BC_LA$fips[which(NEI_BC_LA$fips == "06037")] ="LA County"
NEI_BC_LA$fips[which(NEI_BC_LA$fips == "24510")] ="Baltimore"

## Aggregate NEI_BC_LA data
AggNEI_BC_LA <- aggregate(Emissions ~ year + fips, NEI_BC_LA, sum)

## Scale Emissions to Thousand Tons
AggNEI_BC_LA$Emissions <- AggNEI_BC_LA$Emissions/1000

## Create a Bar Chart
png("plot6.png")

library(ggplot2)
plot <- ggplot(data=AggNEI_BC_LA, mapping=aes(x=factor(year), y=Emissions, fill=fips))
plot + geom_bar(position="dodge", stat="identity") +
    geom_text(aes(label=round(Emissions,3)), vjust=-0.3, hjust=-0.2, size=3.5) +
    labs(x="Year",
         y="PM2.5 Emission (Thousand Tons)",
          title="Amount of PM2.5 Emissions",
         subtitle="Baltimore City vs. Los Angeles County") +
    theme_bw() +
    scale_size(guide="none") +
    guides(fill=guide_legend(title="Region")) 

dev.off()