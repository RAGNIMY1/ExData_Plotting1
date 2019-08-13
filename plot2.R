###################################################################################################################
## EXPLORATORY DATA ANALYSIS - WEEK 1 Project Assignment (PLOT2)   
## 13.08.2019
## Author  : Myriam Ragni
## Dataset : This assignment uses the "Individual household electric power consumption Data Set" providing
##           measurements of electric power consumption in one household with a one-minute sampling rate over a  
##           period of almost 4 years.
##           URL: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## Purpose : Examine how household energy usage varies over a 2-day period in February, 2007 (2007-02-01 and 2007-02-02)
##           and construct the plots using the base plotting system as per sample.
## Prereq. : Fork and clone the following GitHub repository:https://github.com/rdpeng/ExData_Plotting1
## OUtput  : This script will produce plot2.png
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
## Building PLOT2 : Line plot presenting the household global minute-averaged active
## power (in kilowatt) measured the 2007-02-01 and 2007-02-02
## Plot is presented on the console and saved to a PNG file with a width of 
## 480 pixels and a height of 480 pixels.
## =================================================================================
DateTime <- strptime(paste(FilteredData$Date, FilteredData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
with(FilteredData,plot(DateTime,Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.copy(png,filename="plot2.png", width=480, height=480)
dev.off()