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

#3.Plot the second one and creat PNG file
with(ourdata, plot(`Date/Time`, Global_active_power,type = "l",xlab="",ylab = "Global Active Power (kilowatts)"))

dev.copy(png,"plot2.png")
dev.off()