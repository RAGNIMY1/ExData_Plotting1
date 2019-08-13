###################################################################################################################
## EXPLORATORY DATA ANALYSIS - WEEK 1 Project Assignment (PLOT4)   
## 13.08.2019
## Author  : Myriam Ragni
## Dataset : This assignment uses the "Individual household electric power consumption Data Set" providing
##           measurements of electric power consumption in one household with a one-minute sampling rate over a  
##           period of almost 4 years.
##           URL: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## Purpose : Examine how household energy usage varies over a 2-day period in February, 2007 (2007-02-01 and 2007-02-02)
##           and construct the plots using the base plotting system as per sample.
## Prereq. : Fork and clone the following GitHub repository:https://github.com/rdpeng/ExData_Plotting1
## OUtput  : This script will produce plot4.png
## How to run the script: Change the working directory accordingly (setwd command)
###################################################################################################################

#### Estimate of how much memory is required in memory to read the data file
options(scipen=999) # block scientific notation
print(paste((8*2075259*9) / 2^20, 'megabytes'))

## ===============================================================================
## Set the environment
## ===============================================================================
#### Clear variables in the workspace
rm(list = ls())
#### Change locale settings to ensure that date/time is shown in English format
Sys.setlocale("LC_TIME", "English")
#### Set the working directory !!!! TO BE CHANGED ACCORDINGLY
setwd("c:/RAGNIMY1/datasciencecoursera/ExData_Plotting1")


## =================================================================================
## Download and unzip the raw data file
## =================================================================================
SrcFileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
DataFileZip <- "household_power_consumption.zip"
DataFile <- "household_power_consumption.txt"

#### Check if zipped data file was already downloaded, if not, download the file
if (!file.exists(DataFileZip)){
        download.file(SrcFileURL, destfile=DataFileZip)
}

#### Check if unzipped data file exists, if not, unzip the data file
if (!file.exists(DataFile)) { 
        unzip(DataFileZip) 
} 

## =================================================================================
## Read the data file and load it into a data frame
## Note: as we only need a subset of the dataset, I am using the 'sqldf' library to 
## extract the data from the dates 2007-02-01 and 2007-02-02.
## =================================================================================
library(sqldf)
FilteredData <- read.csv.sql(file=DataFile,sql="select * from file WHERE ((Date = '1/2/2007') OR (Date = '2/2/2007'))",
                             sep=";", colClasses=c(rep("character",2),rep("numeric",7))) ##2880 obs. 9 variables

## =================================================================================
## Building PLOT4 : Plot combining multiple charts
##   - Household global minute-averaged active power (in kilowatt) measured the 
##     2007-02-01 and 2007-02-02
##   - Minute-averaged voltage (in volt) measured the 2007-02-01 and 2007-02-02
##   - Energy sub-metering No. 1 to 3 (in watt-hour of active energy) measured
##     the 2007-02-01 and 2007-02-02
##   - Household global minute-averaged reactive power (in kilowatt) measured the 
##     2007-02-01 and 2007-02-02
## Plot is presented on the console and saved to a PNG file with a width of 
## 480 pixels and a height of 480 pixels.
## =================================================================================
par(mfrow = c(2, 2), mar = c(6, 5, 2, 1))
DateTime <- strptime(paste(FilteredData$Date, FilteredData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
#### Chart 1
with(FilteredData, plot(DateTime, Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power"))

#### Chart 2
with(FilteredData, plot(DateTime, Voltage, type="l", col="black", xlab="datetime", ylab="Voltage"))

#### Chart 3
with(FilteredData, {
        plot(DateTime,Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
        lines(DateTime,Sub_metering_2, col="red")
        lines(DateTime,Sub_metering_3, col="blue")
})
legend("topright",col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), lwd=2)

#### Chart 4
with(FilteredData, plot(DateTime, Global_reactive_power, type="l", col="black", xlab="datetime", ylab="Global_reactive_power"))

dev.copy(png,filename="plot4.png", width=480, height=480)
dev.off()