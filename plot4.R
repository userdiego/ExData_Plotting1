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
data$Voltage <- as.numeric(as.character(data$Voltage))


##Multiple plots in one device
png(file = "plot4.png")
par(mfrow = c(2 ,2))

##Plot 1
hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")

##Plot 2
plot(data$datetime, data$Voltage, type = "l", xlab = "", ylab = "Voltage")

##Plot 3
plot(data$datetime, data$Sub_metering_1, type = "l", ylab = "Energy sub metering", ylim = c(0, 35), xlab = "", yaxt = "n")
lines(data$datetime, data$Sub_metering_2, type = "l", col = "red")
lines(data$datetime, data$Sub_metering_3, type = "l", col = "blue")
axis(2, at = c(0 , 10, 20, 30))
legend("topright", pch = "-", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), x.intersp = 0)

## Plot 4
with(data, plot(datetime, Global_reactive_power, type = "l"))

##Close device
dev.off()
