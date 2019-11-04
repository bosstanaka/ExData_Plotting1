#read data
cls <- c(Voltage="numeric", Global_active_power="numeric",Global_intensity="numeric",Sub_metering_1="numeric",Sub_metering_2="numeric",Sub_metering_3="numeric",Global_active_power="numeric",Global_reactive_power="numeric")
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";",dec=".", stringsAsFactors=FALSE, na.strings = "?",colClasses=cls)
energyData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

#make sure data is interpreted correctly
as.Date(energyData$Date)

#deleted all the rows that had NA values
energyData <-na.omit(energyData)

dates <- paste(energyData$Date, energyData$Time)
datetime <- strptime(dates, "%d/%m/%Y %H:%M:%S")

#Make two rows and two columns
par(mfrow=c(2,2))

# First plot - much like plot1.R except the x-axis is different
plot(datetime, energyData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
#axis(1, at = c(1, 1441, 2880), labels=c("Thu", "Fri", "Sat"))

# Second plot - Plotting the voltage
plot(datetime, energyData$Voltage, type="l", ylab="Voltage", xlab="datetime")
#axis(1, at = c(1, 1441, 2880), labels=c("Thu", "Fri", "Sat"))

# Third plot. Exactly like plot3.R
plot(datetime, energyData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black")
lines(datetime, energyData$Sub_metering_2, col="red")
lines(datetime, energyData$Sub_metering_3, col="blue")
#axis(1, at = c(1, 1441, 2880), labels=c("Thu", "Fri", "Sat"))
legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Fourth plot. Plot the global inactive power
plot(datetime, energyData$Global_reactive_power, cex=0.95, type="l", ylab="Global_reactive_power", xlab="datetime", xaxt="n")
#axis(1, at = c(1, 1441, 2880), labels=c("Thu", "Fri", "Sat"))

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
