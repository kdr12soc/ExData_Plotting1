library(tidyverse)


url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(url, destfile = "Electric power consumption.zip")
unzip("Electric power consumption.zip")

df <- read.table(file = "household_power_consumption.txt", header = T, sep = ';', na.strings = '?')

dfsubset <- df %>%
  mutate(Time = strptime(paste(Date, " " ,Time), "%d/%m/%Y %H:%M:%S", tz = "CET"),
         Date = as.Date(Date, "%d/%m/%Y")) %>%
  filter(Date >= "2007-02-01" & Date <= "2007-02-02")

plot(dfsubset$Time, dfsubset$Sub_metering_1, type = "l", xlab = "", xaxt = "n")
lines(dfsubset$Time, dfsubset$Sub_metering_2, type = "l", xaxt = "n", col = "red")
lines(dfsubset$Time, dfsubset$Sub_metering_3, type = "l", xaxt = "n", col = "blue")
axis.POSIXct(1, df$DateTime, format = "%A", at = c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00"))
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()