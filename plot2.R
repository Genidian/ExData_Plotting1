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
png("plot2.png", width = 480, height = 480)
plot(data$t,data$Global_active_power, 
     type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

