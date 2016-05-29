

#temp <- tempfile()
# check for source file in the working directory and down load it if it doesnt
if(!file.exists("exdata-data-household_power_consumption.zip")) {
  cat("Source file doesn't exist . download the file ", getwd())
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
}
sourceFile <- unzip(temp)
unlink(temp) # delete the zip file

# Read the source file and keep it in a table 
#powerConsumptionData <- read.table(sourceFile, header=T, sep=";")
powerConsumptionData <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                                 nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
powerConsumptionData$Date <- as.Date(powerConsumptionData$Date, format="%d/%m/%Y")
#Extract data on 2007-02-01 to 2007-02-02 to a dataframe 
dataFrame <- powerConsumptionData[(powerConsumptionData$Date=="2007-02-01") | (powerConsumptionData$Date=="2007-02-02"),]

#Define appropriate data types
dataFrame$Global_active_power <- as.numeric(as.character(dataFrame$Global_active_power))
dataFrame$Global_reactive_power <- as.numeric(as.character(dataFrame$Global_reactive_power))
dataFrame$Voltage <- as.numeric(as.character(dataFrame$Voltage))
dataFrame <- transform(dataFrame, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
dataFrame$Sub_metering_1 <- as.numeric(as.character(dataFrame$Sub_metering_1))
dataFrame$Sub_metering_2 <- as.numeric(as.character(dataFrame$Sub_metering_2))
dataFrame$Sub_metering_3 <- as.numeric(as.character(dataFrame$Sub_metering_3))


# Plots the graph with Global Active Power (kilowatts) in x axis, colour - RED
plot1 <- function() {
  hist(dataFrame$Global_active_power, main="Global Active Power", 
       xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
    dev.copy(png, file="plot1.png", width=480, height=480)
  dev.off()
}
plot1()