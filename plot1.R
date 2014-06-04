## plot1.R
# Coursera Exploratory Data Analysis 2014
# Course Project 1
# by Janne Simonen

# Data Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.
# 
# The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
#   
#   Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

# read the data
datafile <- "household_power_consumption.txt"
edata <- read.csv(datafile,stringsAsFactors=FALSE,sep = ";", na.strings = "?")

# combine date and time to single string, then 
# convert the strings to date objects
#datetime <- paste(edata[,"Date"],edata[,"Time"])          # date and time string
#datetimeobj <- strptime(datetime,format = "%d/%m/%Y %H:%M:%S")     # date object

# add a datetime column to the data for easier processing
#edata2 <- cbind(edata,datetimeobj)
#names(edata2)[10] <- "Datetime"

edata[,"Date"] <- as.Date(edata[,"Date"],format = "%d/%m/%Y")
#edata[,"Time"] <- strptime(edata[,"Time"],format = "%H:%M:%S")

# subset the data: "We will only be using data from the dates 2007-02-01 and 2007-02-02"
edata2 <- subset(edata,Date > as.Date("2007-01-31"))
edata2 <- subset(edata2,Date < as.Date("2007-02-03"))

# now we have the proper subset of the data so it is time to plot it
hist(edata2$Global_active_power,col = "red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
title(main="Global Active Power")

# save the plot to a png file
dev.copy(png, file = "plot1.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!