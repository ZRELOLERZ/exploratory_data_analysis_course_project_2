library("tidyverse")
dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipFileName <- "emmissions_data.zip"

if (!file.exists(zipFileName)) {
    download.file(dataURL, destfile = zipFileName)
}
unzip(zipfile = zipFileName)

classCodeData <- as_tibble(readr::read_rds("Source_Classification_Code.rds"))
emissionsData <- as_tibble(readr::read_rds("summarySCC_PM25.rds"))

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from all
# sources for each of the years 1999, 2002, 2005, and 2008.

plotData <- emissionsData %>% 
    group_by(year) %>%
    summarize(total = sum(Emissions) / 10^6)

png(filename = "plot1.png", width = 600, height = 600)
barplot(plotData$total,
        names.arg = plotData$year,
        xlab = "Years",
        ylab = "Emissions in tonnes (millions)",
        main = expression("Total US " *PM[2.5]* " Emmissions By Year"),
        col = "steelblue"
        )
dev.off()
