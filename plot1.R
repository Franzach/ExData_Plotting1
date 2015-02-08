# Plot historgram of the active power consumption for first 2 days in Feb 2007
# File downloads data from web, then reads it in and cleans it before applying
# plots

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/household_power_consumption.zip")
unzip("./data/household_power_consumption.zip", exdir = "./data")
consdata <- read.csv2("./data/household_power_consumption.txt", na.strings = "?")

# Clean up data and subset
consdata[[1]] <- as.Date(consdata[[1]], "%d/%m/%Y")
consdata1 <- consdata[consdata$Date == "2007-02-01" | consdata$Date == "2007-02-02",]
#consdata1[[2]] <- strptime(paste(consdata1[[1]], consdata1[[2]]), "%Y-%m-%d %H:%M:%S")
consdata1$Global_active_power <- as.numeric(as.character(consdata1$Global_active_power))

# Plot the data
png(filename = "plot1.png")
hist(consdata1$Global_active_power, col = "red", 
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
