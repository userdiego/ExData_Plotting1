##Download, unzip and read data.

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data.zip")
unzip("data.zip")
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

##Converting to date and time variables
install.packages("lubridate")
library(lubridate)
data$datetime <- dmy_hms(paste(as.character(data$Date), as.character(data$Time)))
data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)

##Subsetting days 
data <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ]

##Changing power variables class to numeric.
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))

##Plotting
plot(data$datetime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

##Saving plot
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
