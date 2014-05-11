#Load data
data <- read.table("household_power_consumption.txt", sep=";", header=T, as.is=T, na.strings="?")

#Only save the days we want
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

#Create POSIXct and POSIXlt columns for combined date and time
makeDate <- function(date, time) as.POSIXct(strptime(paste(date,time),format="%d/%m/%Y %H:%M:%S"))
data$timeCT <- as.POSIXct(mapply(makeDate, data$Date, data$Time, SIMPLIFY=T), origin="1970-01-01", tz="")
data$timeLT <- as.POSIXlt(data$timeCT)

#make the figure and save it to a png file
png(file="plot4.png", width=480, height=480) #set up PNG

originalPar <- par(no.readonly=T) #save par() settings
par(mfrow=c(2,2)) #set up 2x2 grid of plots

#plot plot2 in position (1,1)
plot(data$timeLT,data$Global_active_power, type="n", ylab="Global Active Power (kilowatts)", xlab="") 
lines(data$timeLT, data$Global_active_power)

#plot voltage vs. time in position (1,2)
plot(data$timeLT, data$Voltage, type="n", xlab="datetime", ylab="Voltage")
lines(data$timeLT, data$Voltage)

#plot plot3 in position (2,1)
plot(data$timeLT, data$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(data$timeLT, data$Sub_metering_1, col= "black")
lines(data$timeLT, data$Sub_metering_2, col= "red")
lines(data$timeLT, data$Sub_metering_3, col= "blue")
legend(x= "topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd=1, col=c("black", "red", "blue"), bty="n")

#plot global_reactive_power vs. time in position (2,2)
plot(data$timeLT, data$Global_reactive_power, type="n", xlab="datetime", ylab="Global_Reactive_Power")
lines(data$timeLT, data$Global_reactive_power)
par(originalPar)
dev.off() #close PNG