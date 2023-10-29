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

## Extract Baltimore City and Los Angeles County Data
## Replace fips code with the region name
NEI_BC_LA <- dplyr::filter(NEI, NEI$fips=="24510" | NEI$fips=="06037")
NEI_BC_LA$fips[which(NEI_BC_LA$fips == "06037")] ="LA County"
NEI_BC_LA$fips[which(NEI_BC_LA$fips == "24510")] ="Baltimore"


## Create a Bar Chart
png("plot6.png")

library(ggplot2)
plot <- ggplot(data=NEI_BC_LA, mapping=aes(x=year, y=Emissions, fill=fips))
plot + geom_bar(position="dodge", stat="sum") +
    labs(x="Year",
         y="PM2.5 Emission (Tons)",
          title="Amount of PM2.5 Emissions",
         subtitle="Baltimore City vs. Los Angeles County") +
    theme_bw() +
    scale_size(guide="none") +
    scale_x_continuous(breaks=c(1999, 2002, 2005, 2008)) +
    guides(fill=guide_legend(title="Region")) 

dev.off()

