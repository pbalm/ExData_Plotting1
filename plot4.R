# Produce file short.csv with the scrip in get_short_file.R
# It just selects the dates that we're interested in
filename <- "short.csv"

# Create a timestamp column with POSIXlt objects from the Date and Time columns
data <- read.csv(filename, sep=";")[c("Date", "Time")]
thisformat <- "%d/%m/%Y %H:%M:%S"
timestamp <- strptime(paste(data$Date, data$Time), format=thisformat)
xmin <- as.numeric(strptime("01/02/2007 00:00:00", format=thisformat))
xmax <- as.numeric(strptime("03/02/2007 00:00:00", format=thisformat))

plotTopRight <- function() {
    data <- read.csv(filename, sep=";")["Voltage"]
    Voltage <- data[,1]
    plot(timestamp, Voltage, main="", xlab="datetime", type="l", xlim=c(xmin, xmax))
}

plotBottomRight <- function() {
    colname <- "Global_reactive_power"
    data <- read.csv(filename, sep=";")[colname]
    power <- data[,1]
    plot(timestamp, power, main="", xlab="datetime", ylab=colname, type="l", xlim=c(xmin, xmax), ylim=c(0, 0.5))
}

png(file="plot4.png")

par(mfrow=c(2,2))

fontsizescale <- 0.5
cex.axis <- fontsizescale
cex.lab <- fontsizescale
cex.main <- fontsizescale
cex.sub <- fontsizescale

source("plot2.R")
plotTopRight()
source("plot3.R")
plotBottomRight()

dev.off()
