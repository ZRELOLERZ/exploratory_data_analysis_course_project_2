library("tidyverse")
dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipFileName <- "emmissions_data.zip"

if (!file.exists(zipFileName)) {
    download.file(dataURL, destfile = zipFileName)
}
unzip(zipfile = zipFileName)

classCodeData <- as_tibble(readr::read_rds("Source_Classification_Code.rds"))
emissionsData <- as_tibble(readr::read_rds("summarySCC_PM25.rds"))

# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


grepVehicles <- grep("veh", classCodeData$EI.Sector, ignore.case = TRUE)
filteredSCC <- classCodeData[grepVehicles, "SCC"]
plotData <- emissionsData %>%
    filter(fips == "24510") %>%
    filter(SCC %in% filteredSCC$SCC) %>%
    group_by(year) %>%
    summarise(total_emissions = sum(Emissions))

png(filename = "plot5.png", width = 600, height = 600)

par(bg = "mintcream")

barplot(plotData$total_emissions,
        names.arg = plotData$year,
        xlab = "Years",
        ylab = "Emissions in tonnes",
        ylim = c(0, 400),
        main = expression("Total Baltimore City, MD " *PM[2.5]* " Emmissions From Motor Vehicle Sources By Year"),
        col = "palegreen",
)

dev.off()