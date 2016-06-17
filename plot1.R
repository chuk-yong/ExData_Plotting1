# read in data from 2007 Feb 01 and 02
library(sqldf)
data <- read.csv.sql("household_power_consumption.txt", header = TRUE, sep = ";", sql = 'select * from file where Date == "1/2/2007" or Date == "2/2/2007"')
# 2880 obs or 9 variables

# convert to date
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# convert to time
library(chron)
data$Time <- chron(times = data$Time)

# plot histogram
hist(data$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# save file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
