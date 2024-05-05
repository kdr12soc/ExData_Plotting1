library(tidyverse)


url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(url, destfile = "Electric power consumption.zip")
unzip("Electric power consumption.zip")

df <- read.table(file = "household_power_consumption.txt", header = T, sep = ';', na.strings = '?')

dfsubset <- df %>%
  mutate(Time = strptime(paste(Date, " " ,Time), "%d/%m/%Y %H:%M:%S", tz = "CET"),
         Date = as.Date(Date, "%d/%m/%Y")) %>%
  filter(Date >= "2007-02-01" & Date <= "2007-02-02")

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(dfsubset, {
  plot(dfsubset$Time, dfsubset$Global_active_power, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="", xaxt = "n")
  axis.POSIXct(1, df$DateTime, format = "%A", at = c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00"))
  plot(dfsubset$Time, dfsubset$Voltage, type="l", 
       ylab="Voltage (volt)", xlab="datetime", xaxt = "n")
  axis.POSIXct(1, df$DateTime, format = "%A", at = c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00"))
  plot(dfsubset$Time, dfsubset$Sub_metering_1, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="", xaxt = "n")
  lines(dfsubset$Time, dfsubset$Sub_metering_2,col='Red', xaxt = "n")
  lines(dfsubset$Time, dfsubset$Sub_metering_3,col='Blue', xaxt = "n")
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  axis.POSIXct(1, df$DateTime, format = "%A", at = c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00"))
  plot(dfsubset$Time, dfsubset$Global_reactive_power, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="datetime", xaxt = "n")
  axis.POSIXct(1, df$DateTime, format = "%A", at = c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00"))
})
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()

