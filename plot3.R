# read txt file in
dat <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?",
                nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
dat$Date <- strptime(dat$Date, format="%d/%m/%Y")

# keep just two days' worth of data
data <- subset(dat, dat$Date >= "2007-02-01" & dat$Date <= "2007-02-02")

# combine date and time to a new variable
t <- paste(as.Date(data$Date), data$Time)
data$t <- as.POSIXct(t)

# turn Global active power into numeric, and change unit to kilowatt equivalent
data$Global_active_power <- as.numeric(data$Global_active_power)

# plot hist & paste on png
png("plot3.png", width = 480, height = 480)
plot(data$t,data$Sub_metering_1, col="black",
        type="l", xlab="", ylab="Energy sub meeting")
lines(data$t,data$Sub_metering_2, col="red",
        type="l")
lines(data$t,data$Sub_metering_3, col="blue",
      type="l")
legend("topright", col=c("black","red","blue"), lwd=1,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()