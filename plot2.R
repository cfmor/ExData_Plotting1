# This script is written to comply with Course Project 1 from the Exploratory
# Data Analysis coursera's course. It generates plot2.
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
png("plot2.png")

# Plot the data.
plot(data$Global_active_power ~ data$TimeStamp, 
     ylab="Global Active Power (kilowatts)", 
     xlab="", 
     type="l")

# Save the plot.
dev.off()