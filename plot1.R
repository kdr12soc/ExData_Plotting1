library(tidyverse)


url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(url, destfile = "Electric power consumption.zip")
unzip("Electric power consumption.zip")

df <- read.table(file = "household_power_consumption.txt", header = T, sep = ';', na.strings = '?')

dfsubset <- df %>%
  mutate(Time = strptime(paste(Date, " " ,Time), "%d/%m/%Y %H:%M:%S", tz = "CET"),
         Date = as.Date(Date, "%d/%m/%Y")) %>%
  filter(Date >= "2007-02-01" & Date <= "2007-02-02")

hist(dfsubset$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()