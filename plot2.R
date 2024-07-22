# Load required package
library(sqldf)

# Read only the required dates
data <- read.csv2.sql("household_power_consumption.txt", 
                      sql = "SELECT * FROM file WHERE Date IN ('1/2/2007', '2/2/2007')",
                      na.strings = "?")

# Convert Date and Time to datetime
data$DateTime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Plot 2
png("plot2.png", width = 480, height = 480)
plot(data$DateTime, data$Global_active_power, type="l", 
     xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
