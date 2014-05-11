# Produce file short.csv with the scrip in get_short_file.R
# It just selects the dates that we're interested in
filename <- "short.csv"

# Just a complicated way of getting the Sub_metering_1, 2, 3 col names
sub <- "Sub_metering_"
# Paste the numbers at the end:
cols <- paste(sub, c(1:3), sep="")

data <- read.csv(filename, sep=";")[c("Date", "Time", cols)]

xtitle = "Energy sub metering"

# Create a timestamp column with POSIXlt objects from the Date and Time columns
thisformat <- "%d/%m/%Y %H:%M:%S"
timestamp <- strptime(paste(data$Date, data$Time), format=thisformat)

xmin <- as.numeric(strptime("01/02/2007 00:00:00", format=thisformat))
xmax <- as.numeric(strptime("03/02/2007 00:00:00", format=thisformat))

# All three submetering columns
power <- data[,3:5]
colors <- c("black","red","blue")

legend_box_type <- "n"
ytitle <- "Energy sub metering"

switch_off <- FALSE
# Only print to PNG if we're not printing to PNG already
# That allows me to source this script from plot4.R
if (dev.cur() == 1) {
    png(file="plot3.png")
    switch_off <- TRUE
    
    legend_box_type <- "o"
}

plot(timestamp, power[,1], col=colors[1], main="", xlab="", ylab=ytitle, type="l", xlim=c(xmin, xmax))
lines(timestamp, power[,2], col=colors[2], type="l")
lines(timestamp, power[,3], col=colors[3], type="l")
legend("topright",legend=cols,col=colors,bg="white",lwd=2, bty=legend_box_type)

if (switch_off) {
    dev.off()
}

