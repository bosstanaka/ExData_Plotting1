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

#plot data
par(mfrow=c(1,1))
plot(datetime, energyData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
