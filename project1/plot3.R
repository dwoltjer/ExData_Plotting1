# read classes first to improve read performance total dataset 
tab5rows <- read.table("household_power_consumption.txt", header = TRUE, sep=';', nrows = 5)
classes <- sapply(tab5rows, class)

# read total dataset
xf <- read.table("household_power_consumption.txt", header = TRUE, sep=';', na.string="?", colClasses = classes)

# convert date field tot Date format
dates <- xf$Date
dates <- as.Date(as.character(dates),"%d/%m/%Y")
xf$Date <- dates

# create subset for plot (1st 2 days of feb 2007)
xp <- subset(xf, Date == '2007-02-01' | Date == '2007-02-02')

# combine datetime variable
xp$DateTime <- as.POSIXct(paste(xp$Date, xp$Time), format="%Y-%m-%d %H:%M:%S")

# open device png
png("plot3.png")

#draw chart
plot(xp$DateTime,xp$Sub_metering_1, xlab="",ylab="Energy sub metering",type="l")
lines(xp$DateTime,xp$Sub_metering_2, col='red')
lines(xp$DateTime,xp$Sub_metering_3, col='blue')
legend("topright", c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col = c("black", "red","blue"),lwd=1)


# close device
dev.off()
