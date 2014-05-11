plot2 <- function() {
     globalAP <- loadData()
     dateTimeVals <- paste(globalAP$Date, globalAP$Time, sep=" ")
     dateTimeVals <- strptime(dateTimeVals, format="%Y-%m-%d %H:%M:%S")
     
     png(file="./plot2.png")
     plot (dateTimeVals, globalAP$Global_active_power, type="l", xlab="",
           ylab="Global Active Power (kilowatts)")
     dev.off()
}


loadData <- function() {
     ## Load and format the data set, downloading the source if necessary
     
     ## Source data file is assumed to be ./data/ehpc.txt. If it does not 
     ## exist, download and/or extract it
     if (!file.exists("./data/household_power_consumption.txt")) {
          
          ## If the zip file does not exist, download it
          if (!file.exists("./data/ehpc.zip")) {
               if (!file.exists("./data")) {
                    dir.create("./data")
               }
               
               fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
               download.file(fileURL,"./data/ehpc.zip")
          }
          
          ## Extract data source
          unzip("./data/ehpc.zip", exdir="./data")
     }
     sourceFilename <- "./data/household_power_consumption.txt"
     
     
     ## Load data into data frame, subset to correct rows, clean up data
     data <- suppressWarnings(fread(sourceFilename, sep=";", header=TRUE))
     data <- data[(data$Date == "1/2/2007") | (data$Date == "2/2/2007"),]
     
     
     
     ## This isn't working, commenting out
     ## Paste Date and Time columns together into one column
     # tempDT <- paste(data$Date, data$Time, sep = " ")
     # data$DateTime <- tempDT
     
     ## Convert Date and Time column from character to POSIXlt class
     # data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
     
     
     
     ## Convert Date column from character to Date class
     data$Date <- as.Date(data$Date, format="%d/%m/%Y")
     
     ## Convert measurement columns from character to numeric class
     data$Global_active_power <- as.numeric(data$Global_active_power)
     data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
     data$Voltage <- as.numeric(data$Voltage)
     data$Global_intensity <- as.numeric(data$Global_intensity)
     data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
     data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
     data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
     
     return(data)
}
