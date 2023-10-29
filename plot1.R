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

## Sum Emissions Column by Year
tapply(NEI$Emissions, NEI$year, sum)
EmissionSum=c(7332967, 5635780, 5454703, 3464206)
EmissionSumMil=EmissionSum/1000000
year=c(1999, 2002, 2005, 2008)

## Create a Bar Plot
#     1. Set the margin.
#     2. Creates an empty plot.
#     3. Adds a bar plot.
#     4. Saves the plot.
par(mar=c(3,5,3,1))

png("plot1.png")
plot(1, type="n")
barplot(EmissionSumMil, names.arg=year,
        main="Amount of PM2.5 Emission in the U.S., 1999-2008",
        xlab="Year",
        ylab="PM2.5 Emission (Million Tons)",
)
dev.off()
