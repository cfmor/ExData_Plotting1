# This script is written to comply with Course Project 1 from the Exploratory
# Data Analysis coursera's course. It generates plot4.
# author: cfmor
# date: 03.11.2021

#### Packages ####
library(ggplot2)
library(dplyr)


#### Retrieve the data ####
data <- data.table::fread("household_power_consumption.txt", 
                          header=T,
                          nrows=2075259, 
                          sep=";", 
                          na.strings="?")

# Convert Dates to datetime objects.
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Subset the data.
data <- subset(data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# Merge Datetime data and put it into data subset table.
TimeStamp <- paste(data$Date, data$Time)
TimeStamp <- setNames(TimeStamp, "TimeStamp")
data <- data %>% select(-(Date:Time))
data <- cbind(TimeStamp, data)
data$TimeStamp <- as.POSIXct(TimeStamp)


#### Plotting ####
# Open device.
png("plot4.png")

# Plot the data.
par(mfcol=c(2,2))

plot(data$Global_active_power ~ data$TimeStamp, 
     xlab="", 
     ylab="Global Active Power", 
     type="l")

plot(data$Sub_metering_1 ~ data$TimeStamp, 
     xlab="", 
     ylab="Energy sub metering", 
     type="l")
lines(data$Sub_metering_2 ~ data$TimeStamp, col="RED")
lines(data$Sub_metering_3 ~ data$TimeStamp, col="blue")
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(data$Voltage ~ data$TimeStamp, 
     xlab="datetime", 
     ylab="Voltage", 
     type="l")

plot(data$Global_reactive_power ~ data$TimeStamp, 
     xlab="datetime", 
     ylab="Global_reactive_power",
     type="l")

# Save the plot.
dev.off()

