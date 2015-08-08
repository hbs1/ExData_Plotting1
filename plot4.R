##Open url to file; zip file.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- 'household_power_consumption.txt'
if (!file.exists(filename)) download(url, destfile=filename)



##read in data
hpower <- read.table('household_power_consumption.txt', header=F, sep=';',na.strings='?', skip=66600, nrows=3000 )
 
##combine dates
h2 <- subset(hpower, grepl('1/2/2007', hpower$V1))
h3 <- subset(hpower, grepl('2/2/2007', hpower$V1))
hpower2 <- rbind(h2, h3)

##give variables more meaningful col names

names(hpower2) <- c('Date', 'Time', 'ActivePower', 'ReactivePower', 'Voltage', 'Intensity', 'Metering1', 'Metering2', 'Metering3')

##combine Date and Time to one variable
datetime <- paste(hpower2$Date, hpower2$Time)

##put the variable into the dataframe
hpower2$datetime <- datetime

##review structure of the dataframe
str(hpower2)

##change variable to POSIX format

hpower2$datetime <- strptime(hpower2$datetime, "%d/%m/%Y %H:%M:%S")

## plot the required variables

##plot3 <- plot(hpower2$datetime, hpower2$Metering1, hpower$Metering2, hpower$Metering3, type = 'l',  ylab ="Energy_sub_metering")

par(mfrow = c(2,2), mar=c(6,4,1,3), oma=c(2,0,0,0), cex = .6)
with(hpower2, {
	plot(datetime, ActivePower, ylab= 'Global Active Power', xlab=' ', type='l')
	plot(hpower2$datetime, hpower2$Voltage, type = 'l',  xlab='datetime', ylab = 'Voltage')
	plot(hpower2$datetime, hpower2$Metering1, type = 'l',xlab=' ', ylab ="Energy/sub metering")
		lines(hpower2$datetime, hpower2$Metering2, col = 'red')
		lines(hpower2$datetime, hpower2$Metering3, col = 'blue')
		legend('topright', lwd=1, cex=.7, bty='n', col=c('black', 'red', 			'blue'),legend=c('Sub_metering_1','Sub_metering_2', 'Sub_metering_3'))

	plot(hpower2$datetime, hpower2$ReactivePower, type = 'l', xlab='datetime', ylab ="Global_reactive_power")
})


