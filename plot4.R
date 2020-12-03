library(dplyr)
library(plyr)
dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipFileName <- "emmissions_data.zip"

if (!file.exists(zipFileName)) {
    download.file(dataURL, destfile = zipFileName)
}

unzip(zipfile = zipFileName)

classCodeData <- readRDS("Source_Classification_Code.rds")
emissionsData <- readRDS("summarySCC_PM25.rds")

coalSCCId <- classCodeData[grepl("Coal", classCodeData$EI.Sector), c(1)]
