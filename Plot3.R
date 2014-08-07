# Reads in a file and plots data
# Set working directory to that from which data is retrieved from
setwd("E:/Users/JeffPat390039/Documents/Machine_Learning/R/Data_Science/4_Exploratory_Data_Analysis/Week1/exdata-data-household_power_consumption")

# Read in file from working directory
# Note that the sqldf package was used and loaded.  
# Then the read.csv.sql function was used to read in the file from the rows for the Dates ranging from 
# 1/2/2007 to 2/2/2007
# Alternatively, using the read.csv function, we need to know from which rows to read the data from
# The data is found between the rows 66637 and 69517
library(sqldf)
dat <- read.csv.sql("household_power_consumption.txt", sep = ";", sql = 'select * from file where Date = "1/2/2007" OR Date = "2/2/2007"')

#Combine Date and Time columns and over-write into the Date column in dat
dat$Date <- strptime(paste(dat$Date,dat$Time),"%d/%m/%Y %H:%M:%S")

# After data has been retrieved, re-set working directory to that in which the plot will be saved
setwd("E:/Users/JeffPat390039/Documents/Machine_Learning/R/Data_Science/4_Exploratory_Data_Analysis/Week1/Project_Assignment1")

# Set mfrow to be 1 row and 1 column
par(mfrow = c(1,1))

# Plot a scatterplot of Energy Sub Metering and colour it black, red and blue respectively.  
# for Sub_metering_1, Sub_metering_2 and sub_metering_3
with(dat,plot(dat$Date,dat$Sub_metering_1, type = "l", col = 1, xlab = "", ylab = "Energy sub metering", ylim = range(c(dat$Sub_metering_1, dat$Sub_metering_2, dat$Sub_metering_3))))

# Add 2nd plot of Sub_metering_2 on the same axes as Sub_metering_1
lines(dat$Date,dat$Sub_metering_2, type = "l", col = "red")

# Add 3rd plot of Sub_metering_3 on the same axes as Sub_metering_1 and Sub_metering_2
lines(dat$Date,dat$Sub_metering_3, type = "l", col = "blue")

# Plot legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), 
       col = c("black", "red", "blue"), cex = 0.7)

# Copy plot the plot to a PNG file
dev.copy(png, file = "plot3.png")
dev.off()  # Close the png device