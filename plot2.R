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

plot(hpower2$datetime, hpower2$ActivePower, type = 'l', ylab ="Global Active Power (kilowatts)")