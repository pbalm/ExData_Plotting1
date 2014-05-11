# Produce file short.csv with the scrip in get_short_file.R
# It just selects the dates that we're interested in
filename <- "short.csv"
data <- read.csv(filename, sep=";")["Global_active_power"]
power <- data[,1]
switch_off <- FALSE
# Only print to PNG if we're not printing to PNG already
# That allows me to source this script from plot4.R
if (dev.cur() == 1) {
    png(file="plot1.png")
    switch_off <- TRUE
}
mytitle = "Global Active Power"
hist(power, col="red", main=mytitle, xlab=paste(mytitle, "(kilowatts)"), ylim=c(0,1200))
if (switch_off) {
    dev.off()
}
