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

##Plotting in graphic device and saving

png(file = "plot3.png")

plot(data$datetime, data$Sub_metering_1, type = "l", ylab = "Energy sub metering", ylim = c(0, 35), xlab = "", yaxt = "n")
lines(data$datetime, data$Sub_metering_2, type = "l", col = "red")
lines(data$datetime, data$Sub_metering_3, type = "l", col = "blue")
axis(2, at = c(0 , 10, 20, 30))
legend("topright", pch = "-", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), x.intersp = 0)

dev.off()