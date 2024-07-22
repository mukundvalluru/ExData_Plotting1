# Load required package
library(sqldf)

# Read only the required dates
data <- read.csv2.sql("household_power_consumption.txt", 
                      sql = "SELECT * FROM file WHERE Date IN ('1/2/2007', '2/2/2007')",
                      na.strings = "?")

# Convert Date and Time to datetime
data$DateTime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Plot 4
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

plot(data$DateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

plot(data$DateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(data$DateTime, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=1, bty="n", cex=0.5)

plot(data$DateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power")

dev.off()
