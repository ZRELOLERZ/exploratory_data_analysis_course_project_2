library("tidyverse")
dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipFileName <- "emmissions_data.zip"

if (!file.exists(zipFileName)) {
    download.file(dataURL, destfile = zipFileName)
}
unzip(zipfile = zipFileName)

classCodeData <- as_tibble(readr::read_rds("Source_Classification_Code.rds"))
emissionsData <- as_tibble(readr::read_rds("summarySCC_PM25.rds"))

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
# variable, which of these four sources have seen decreases in emissions from 1999–2008
# for Baltimore City? Which have seen increases in emissions from 1999–2008?
# Use the ggplot2 plotting system to make a plot answer this question.

baltimoreData <- emissionsData[emissionsData$fips == "24510",]

png(filename = "plot3.png", width = 600, height = 600)

ggplot(baltimoreData, aes(x = factor(year), y = Emissions, fill = year)) +
    geom_bar(stat = "identity") +
    facet_grid(. ~ type) +
    labs(x = "Year",
         y = expression("Total "*PM[2.5]*"Emissions (tonnes)"),
         title = expression(atop("Total "*PM[2.5]*" Emissions By Source Type", "For Baltimore City, MD (1999 - 2008)"))
         ) +
    theme(plot.title = element_text(hjust = 0.5))

dev.off()
