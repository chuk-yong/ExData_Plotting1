# read in data between 2007 Feb 01 and 02
library(sqldf)
data <- read.csv.sql("household_power_consumption.txt", header = TRUE, sep = ";", sql = 'select * from file where Date == "1/2/2007" or Date == "2/2/2007"')
# 2880 obs or 9 variables

# date conversion
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# time conversion
library(chron)
data$Time <- chron(times = data$Time)

# add a column with date & time
datetime <- paste(data$Date, data$Time)
data$Datetime <- as.POSIXct(datetime)

# Plot graph 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

# save file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()