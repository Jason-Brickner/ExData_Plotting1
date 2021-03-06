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

#Make Plot 4
png("plot4.png", width = 480, height = 480)
par(mfcol = c(2,2))
plot(df$DT, df$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
with(df, plot(DT, Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering", xlab = ""))
        lines(df$DT, df$Sub_metering_2, col = "red")
        lines(df$DT, df$Sub_metering_3, col = "blue")
        legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
plot(df$DT, df$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
plot(df$DT, df$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()

