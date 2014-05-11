# Produce file short.csv with the scrip in get_short_file.R
# It just selects the dates that we're interested in
filename <- "short.csv"
data <- read.csv(filename, sep=";")[c("Date", "Time", "Global_active_power")]
mytitle = "Global Active Power"

# Create a timestamp column with POSIXlt objects from the Date and Time columns
thisformat <- "%d/%m/%Y %H:%M:%S"
timestamp <- strptime(paste(data$Date, data$Time), format=thisformat)

xmin <- as.numeric(strptime("01/02/2007 00:00:00", format=thisformat))
xmax <- as.numeric(strptime("03/02/2007 00:00:00", format=thisformat))

power <- data[,3]

ytitle = mytitle

switch_off <- FALSE
# Only print to PNG if we're not printing to PNG already
# That allows me to source this script from plot4.R
if (dev.cur() == 1) {
    png(file="plot2.png")
    switch_off <- TRUE
    
    ytitle = paste(mytitle, "(kilowatts)")
}



plot(timestamp, power, main="", xlab="", ylab=ytitle, type="l", xlim=c(xmin, xmax))

if (switch_off) {
    dev.off()
}
