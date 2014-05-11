#Load data
data <- read.table("household_power_consumption.txt", sep=";", header=T, as.is=T, na.strings="?")

#Only save the days we want
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

#Create POSIXct and POSIXlt columns for combined date and time
makeDate <- function(date, time) as.POSIXct(strptime(paste(date,time),format="%d/%m/%Y %H:%M:%S"))
data$timeCT <- as.POSIXct(mapply(makeDate, data$Date, data$Time, SIMPLIFY=T), origin="1970-01-01", tz="")
data$timeLT <- as.POSIXlt(data$timeCT)

#make the figure and save it to a png file
png(file="plot1.png", width=480, height=480) # set up PNG

#Draw the histogram with color, title, and label for x-axis
hist(data$Global_active_power, main= "Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
dev.off()  #close PNG