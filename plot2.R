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

#Make plot 2 (line graph)
with(data, plot(Timestamp, Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "n"))
with(data, lines(Timestamp, Global_active_power))