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

# change the date column into a date object that contains the time as well
datetime <- paste(edata[,"Date"],edata[,"Time"])          # date and time string
datetimeobj <- strptime(datetime,format = "%d/%m/%Y %H:%M:%S")     # date object
edata$Date <- datetimeobj

# subset the data: "We will only be using data from the dates 2007-02-01 and 2007-02-02"
# there's something funny about the definition of ">" for dates - it works like ">="
edata2 <- subset(edata,Date > strptime("2007-02-01",format = "%Y-%m-%d"))
edata2 <- subset(edata2,Date < strptime("2007-02-03",format = "%Y-%m-%d"))

# make the line plot
# note that the x-axis abbreviated days are in Finnish, my locale!
Sys.setlocale(category = "LC_TIME", locale="English")
par(mfrow = c(2, 2)) # 2 by 2 plot matrix
# fig 1
with(edata2,plot(Date,Global_active_power,xlab="",ylab="Global Active Power",type="l"))
# fig 2
with(edata2,plot(Date,Voltage,type="l",xlab="datetime"))
# fig 3
with(edata2,plot(Date,Sub_metering_1,type="l",col="black",xlab="",ylab="Energy sub metering"))
with(edata2,lines(Date,Sub_metering_2,type="l",col="red"))
with(edata2,lines(Date,Sub_metering_3,type="l",col="blue"))
legend("topright",lty=c(1,1),col = c("black", "red", "blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n",y.intersp=0.8)
# fig 4
with(edata2,plot(Date,Global_reactive_power,type="l",xlab="datetime"))

# save the plot to a png file
dev.copy(png, file = "plot4.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!
