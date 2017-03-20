#1.Set working directory and time to "English"
#setwd("./household_power_consumption/plot1.R")
Sys.setlocale("LC_TIME","English")
library(dplyr)
library(tidyr)

#2.Label the column name and read the txt file from 2007-02-01 to 2007-02-02, convert the Date and Time variables to Date/Time classes
columnname = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

first <- grep("1/2/2007",readLines("household_power_consumption.txt"))[1]
ourdata <- read.table("household_power_consumption.txt",skip=first-1,nrows = 2*24*60,sep = ";", col.names = columnname) %>%
  unite_("Date/Time", c("Date","Time"),sep = " ")
ourdata$`Date/Time` <-  strptime(ourdata$`Date/Time`, "%d/%m/%Y %H:%M:%S")

#3.Plot the last one and creat PNG file
par(mfrow = c(2, 2),mar = c(4, 2, 2, 1))
with(ourdata, plot(`Date/Time`, Global_active_power,type = "l",xlab="",ylab = "Global Active Power (kilowatts)"))
with(ourdata, plot(`Date/Time`, Voltage,type = "l",xlab="datetime",ylab = "Voltage"))
with(ourdata, {plot(`Date/Time`, Sub_metering_1 , xlab= "",ylab = "Energy sub metering",type = "l")
               points(`Date/Time`, Sub_metering_2 , type = "l",col="red")
               points(`Date/Time`, Sub_metering_3 , type = "l",col="blue")})
legend("topright", lty=1, col = c("black","blue", "red"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.8,y.intersp=0.3,bty='n')
with(ourdata, plot(`Date/Time`, Global_reactive_power,type = "l",xlab="datetime",ylab = "Global Reactive Power",lwd = 0.2))

dev.copy(png,"plot4.png")
dev.off()