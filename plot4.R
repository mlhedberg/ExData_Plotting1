#Read rows containing key dates
data <- fread("household_power_consumption.txt", nrows = 6000, skip=64000)

#Add names header
header <- fread("household_power_consumption.txt", nrows = 1)
new <- colnames(header)
old <- colnames(data)
setnames(data, old, new)

#Adjust column classes
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data[, Timestamp:= as.POSIXct(paste(Date, Time), "%Y-%m-%d %H:%M:%S", tz = "")]
#Repeat for time column

#Subset desired dates
data <- data[Date >= "2007-02-01"]
data <- data[Date < "2007-02-03"]

#Convert missing values from ? to NA

#Make plot 4 (square of 4 plots)
par(mfrow = c(2, 2))
with(data, {
        plot(Timestamp, Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "n")
        with(data, lines(Timestamp, Global_active_power))
        plot(Timestamp, Voltage, xlab = "datetime", ylab = "Voltage", type = "n")
        with(data, lines(Timestamp, Voltage))
        plot(Timestamp, Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n")
        with(data, lines(Timestamp, Sub_metering_1))
        with(data, lines(Timestamp, Sub_metering_2, col = "red"))
        with(data, lines(Timestamp, Sub_metering_3, col = "blue"))
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c("solid", "solid", "solid"), col = c("black", "red", "blue"), xjust = "0", cex=.45)
        plot(Timestamp, Global_reactive_power, xlab = "datetime", type = "n")
        with(data, lines(Timestamp, Global_reactive_power))
})