# Plot graphic of the energy sub-metering for first 2 days in Feb 2007
# File downloads data from web, then reads it in and cleans it before applying
# plots

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/household_power_consumption.zip")
unzip("./data/household_power_consumption.zip", exdir = "./data")
consdata <- read.csv2("./data/household_power_consumption.txt", na.strings = "?")

# Clean up data and subset
consdata[[1]] <- as.Date(consdata[[1]], "%d/%m/%Y")
consdata1 <- consdata[consdata$Date == "2007-02-01" | consdata$Date == "2007-02-02",]
consdata1$Global_active_power <- as.numeric(as.character(consdata1$Global_active_power))
consdata1$Time <- strptime(paste(consdata1$Date, consdata1$Time), "%Y-%m-%d %H:%M:%S")
consdata1$Sub_metering_1 <- as.numeric(as.character(consdata1$Sub_metering_1))
consdata1$Sub_metering_2 <- as.numeric(as.character(consdata1$Sub_metering_2))
consdata1$Sub_metering_3 <- as.numeric(as.character(consdata1$Sub_metering_3))

consdata1$Global_reactive_power <- as.numeric(as.character(consdata1$Global_reactive_power))
consdata1$Voltage <- as.numeric(as.character(consdata1$Voltage))

# Plot the data - 4 charts total 2 x 2 by row
png(filename = "plot4.png")
par(mfrow = c(2, 2))

# 1 Global Active Power plot
plot(x = consdata1$Time, y = consdata1$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power")

# 2 Voltage plot
plot(x = consdata1$Time, y = consdata1$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage")

# 3 Sub metering plot
plot(x = consdata1$Time, y = consdata1$Sub_metering_1, type = "n", 
     xlab = "", ylab = "Energy sub metering")
points(x = consdata1$Time, y = consdata1$Sub_metering_1, type = "S", col = "black")
points(x = consdata1$Time, y = consdata1$Sub_metering_2, type = "S", col = "red")
points(x = consdata1$Time, y = consdata1$Sub_metering_3, type = "S", col = "blue")
legend("topright", bty = "n", lty = 1, lwd = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# 4 Global reactive Power plot
plot(x = consdata1$Time, y = consdata1$Global_reactive_power, type = "l", 
          xlab = "datetime", ylab = "Global_reactive_Power")

dev.off()
