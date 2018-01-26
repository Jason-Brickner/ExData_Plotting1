library(data.table)
library(lubridate)
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "energy.zip")
unzip("energy.zip")
DF <- fread("household_power_consumption.txt")
DF$Date <- as.Date(DF$Date, format = "%d/%m/%Y")
df <- rbind(subset(DF, Date == "2007-02-01"), subset(DF, Date == "2007-02-02"))
df$day <- weekdays(df$Date)
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Voltage <- as.numeric(df$Voltage)
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
df$DT <- paste(df$Date, df$Time, sep = " ") 
df$DT <- ymd_hms(df$DT)

#Make Plot 1
png("plot1.png", width = 480, height = 480)
hist(df$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (killowatts)", ylab = "Frequency")
dev.off()


