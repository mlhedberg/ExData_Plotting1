#Read rows containing key dates
data <- fread("household_power_consumption.txt", nrows = 6000, skip=64000)

#Add names header
header <- fread("household_power_consumption.txt", nrows = 1)
new <- colnames(header)
old <- colnames(data)
setnames(data, old, new)

#Adjust column classes
data$Date <- as.Data(data$Date, "%d/%m/%Y")
data[, Timestamp:= as.POSIXct(paste(Date, Time), "%Y-%m-%d %H:%M:%S", tz = "")]
#Repeat for time column

#Subset desired dates
data <- data[Date >= "2007-02-01"]
data <- data[Date < "2007-02-03"]

#Convert missing values from ? to NA

#Make plot 3 (line graph with 3 variables)
with(data, plot(Timestamp, Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n"))
with(data, lines(Timestamp, Sub_metering_1))
with(data, lines(Timestamp, Sub_metering_2, col = "red"))
with(data, lines(Timestamp, Sub_metering_3, col = "blue"))

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c("solid", "solid", "solid"), col = c("black", "red", "blue"), xjust = "0", cex=.65)