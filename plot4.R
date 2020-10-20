library(dplyr)
library(lubridate)

# Read the data file into a dataframe
fp <- file.path(getwd(), "data", "household_power_consumption.txt")
hpcDf <- read.csv(fp, sep=';', na.strings = '?')

colnames(hpcDf) <- c('date',
                     'time',
                     'global_active_power',
                     'global_reactive_power',
                     'voltage',
                     'global_intensity',
                     'sub_metering_1',
                     'sub_metering_2',
                     'sub_metering_3')
hpcDf <- hpcDf %>%
  mutate(date_time = dmy_hms(paste(date, time)), .before = date) %>%
  select(-(date:time)) %>%
  filter(date_time >= dmy_hms("01/02/2007 00:00:00") &
           date_time <= dmy_hms("02/02/2007 23:59:59")) %>%
  mutate(global_active_power   = as.numeric(global_active_power)) %>%
  mutate(global_reactive_power = as.numeric(global_reactive_power)) %>%
  mutate(voltage               = as.numeric(voltage)) %>%
  mutate(global_intensity      = as.numeric(global_intensity)) %>%
  mutate(sub_metering_1        = as.numeric(sub_metering_1)) %>%
  mutate(sub_metering_2        = as.numeric(sub_metering_2)) %>%
  mutate(sub_metering_3        = as.numeric(sub_metering_3))

dev.off()
par(mfrow = c(2, 2))

plot(hpcDf$date_time, hpcDf$global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

plot(hpcDf$date_time, hpcDf$voltage, type = "l", ylab = "Voltage", xlab = "datetime")

plot(hpcDf$date_time, hpcDf$sub_metering_1, type = 'l', xlab = '', ylab = 'Energy sub metering')
lines(hpcDf$date_time, hpcDf$sub_metering_2, col = 'red')
lines(hpcDf$date_time, hpcDf$sub_metering_3, col = 'blue')
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(hpcDf$date_time, hpcDf$global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.copy(png, file = "plot4.png")
dev.off()