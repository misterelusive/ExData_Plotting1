# Implementing plot3

#
# Function to get the data from the zip archive
# 
# Note - The file has been downloaded and saved on the local drive.
#        Later we are just unzipping it to extract the required file.
#
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

#
# Function to draw the plot
#
makePlot3 <- function() {
    dataTable <- getData()
    
	# saving the plot generated in the required format
	png(filename = "plot3.png", width = 480, height = 480, units = "px")
	
    cols = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    plot(dataTable$DateTime, dataTable$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    lines(dataTable$DateTime, dataTable$Sub_metering_2, type="l", col="red")
    lines(dataTable$DateTime, dataTable$Sub_metering_3, type="l", col="blue")
    legend("topright", lty=1, lwd=1, col=c("black","blue","red"), legend=cols)
    dev.off()
}

makePlot3()