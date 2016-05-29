plot2 <- function() {
  #plot the graph of Global active power against the days 
  plot(dataFrame$timestamp,dataFrame$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  dev.copy(png, file="plot2.png", width=480, height=480)
  dev.off()
}
plot2()