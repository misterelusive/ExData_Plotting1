getData <- function() {
    tempFile <- "plot_data.csv"
    if(file.exists(tempFile)) {
        dataTable <- read.csv(tempFile)
        dataTable$DateTime <- strptime(dataTable$DateTime, "%Y-%m-%d %H:%M:%S")
    }
    else {
		if (!file.exists("exdata-data-household_power_consumption.zip.zip")) {
			fileConnection <- unzip("H:\\Coursera\\John Hopkins\\Exploratory Data Analysis\\Week 1\\Assignment 1\\exdata-data-household_power_consumption.zip")
		}
        dataTable <- read.table(fileConnection, header=T, sep=';', na.strings="?", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
        dataTable <- dataTable[(dataTable$Date == "1/2/2007") | (dataTable$Date == "2/2/2007"),]
        dataTable$DateTime <- strptime(paste(dataTable$Date, dataTable$Time), "%d/%m/%Y %H:%M:%S")
        write.csv(dataTable, tempFile)
    }
    dataTable
}

makePlot1 <- function() {
    dataTable <- getData()
    png(filename = "plot1.png", width = 480, height = 480, units = "px")
    hist(dataTable$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
    dev.off()
}

makePlot1()