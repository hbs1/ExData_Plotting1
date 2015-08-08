##Open url to file; zip file.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- 'household_power_consumption.txt'
if (!file.exists(filename)) download(url, destfile=filename)


##Read in data; skip 66600 rows
hpower <- read.table('household_power_consumption.txt', header=F, sep=';',na.strings='?', skip=66600, nrows=3000 )

##create two subsets of the data
h2 <- subset(hpower, grepl('1/2/2007', hpower$V1))
h3 <- subset(hpower, grepl('2/2/2007', hpower$V1))
hpower2 <- rbind(h2, h3)

##review str hpower2
str(hpower2)
##rename hpower2 headings
names(hpower2) <- c('Date', 'Time', 'ActivePower', 'ReactivePower', 'Voltage', 'Intensity', 'Metering1', 'Metering2', 'Metering3')

##rename Heading and add x-label

par(mar=c(8,4,2,2))
hist(hpower2$ActivePower, col= 'red', main='Global Active Power', xlab='Global Active Power (kilowatts)')
