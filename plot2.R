library("tidyverse")
dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipFileName <- "emmissions_data.zip"

if (!file.exists(zipFileName)) {
    download.file(dataURL, destfile = zipFileName)
}
unzip(zipfile = zipFileName)

classCodeData <- as_tibble(readr::read_rds("Source_Classification_Code.rds"))
emissionsData <- as_tibble(readr::read_rds("summarySCC_PM25.rds"))


# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

png(filename = "plot2.png", width = 600, height = 600)

plotData <- emissionsData[emissionsData$fips == "24510",] %>%
   group_by(year) %>%
    summarise(total_emmissions = sum(Emissions) / 10^3)

barplot(plotData$total_emmissions,
        names.arg = plotData$year,
        xlab = "Years",
        ylab = "Emissions in tonnes (thousands)",
        main = expression("Total Baltimore City " *PM[2.5]* " Emmissions By Year"),
        col = "steelblue"
)

dev.off()