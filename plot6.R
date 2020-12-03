library("tidyverse")
dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipFileName <- "emmissions_data.zip"

if (!file.exists(zipFileName)) {
    download.file(dataURL, destfile = zipFileName)
}
unzip(zipfile = zipFileName)

classCodeData <- as_tibble(readr::read_rds("Source_Classification_Code.rds"))
emissionsData <- as_tibble(readr::read_rds("summarySCC_PM25.rds"))

# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?


grepVehicles <- grep("veh", classCodeData$EI.Sector, ignore.case = TRUE)
filteredSCC <- classCodeData[grepVehicles, "SCC"]
plotData <- filter(emissionsData, (fips == "24510" | fips == "06037") & SCC %in% filteredSCC$SCC)

png(filename = "plot6.png", width = 600, height = 600)

ggplot(data = plotData, aes(x = factor(year), y = Emissions, fill = fips)) +
    geom_bar(stat = "identity") +
    facet_grid(.~fips) +
    labs(x = "Year", y = expression(PM[2.5]*" in tonnes")) +
    ggtitle(expression(PM[2.5]*" Vehicle Emissions By County")) +
    scale_fill_discrete(name = "County",
                        breaks = c("06037", "24510"),
                        labels = c("Los Angeles County", "Baltimore City")
                        ) +
    theme(plot.title = element_text(hjust = 0.5))

dev.off()