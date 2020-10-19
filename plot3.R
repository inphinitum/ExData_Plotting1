plot(hpcDf$date_time, hpcDf$sub_metering_1, type = 'l', xlab = '', ylab = 'Energy sub metering')
lines(hpcDf$date_time, hpcDf$sub_metering_2, col = 'red')
lines(hpcDf$date_time, hpcDf$sub_metering_3, col = 'blue')
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))