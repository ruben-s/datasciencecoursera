data <- read.table(file="household_power_consumption.txt", sep=";",header=TRUE, dec=".",na.strings="?", colClasses=c("character","character","numeric"))
data$DateTime <- paste(data$Date, data$Time, sep="-")
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y-%H:%M:%S")
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data_smaller <- data[ data$Date < "2007-02-03",]
data <- data_smaller[data_smaller$Date > "2007-01-31", ]
plot(x=data$DateTime, y=data$Sub_metering_1,type="l", xlab="", ylab="Energy Sub Metering")
lines(x=data$DateTime, y=data$Sub_metering_2, col="red")
lines(x=data$DateTime, y=data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"), lty=1, col=c("black", "red", "blue"), cex=.75)
dev.copy(png,file="plot3.png", width=480, height=480)
dev.off()