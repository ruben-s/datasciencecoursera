data <- read.table(file="household_power_consumption.txt", sep=";",header=TRUE, dec=".",na.strings="?", colClasses=c("character","character","numeric"))
data$DateTime <- paste(data$Date, data$Time, sep="-")
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y-%H:%M:%S")
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data_smaller <- data[ data$Date < "2007-02-03",]
data <- data_smaller[data_smaller$Date > "2007-01-31", ]
plot(x=data$DateTime, y=data$Global_active_power,type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png,file="plot2.png", width=480, height=480)
dev.off()