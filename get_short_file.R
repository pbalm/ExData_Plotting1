data <- read.csv("household_power_consumption.txt", sep=";")
sel <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]
write.table(sel, file="short.csv", sep=";")
