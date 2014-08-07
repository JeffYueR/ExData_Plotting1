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

# Plot a scatter plot of Global Active Power and colour it black.  Title is Global Active Power
with(dat, plot(dat$Date, dat$Global_active_power, type = "l", col = 1, xlab = "", 
               ylab = "Global Active Power (kilowatts)"))

# Copy plot the plot to a PNG file
dev.copy(png, file = "plot2.png")
dev.off()  # Close the png device