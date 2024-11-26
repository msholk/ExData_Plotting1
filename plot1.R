# Read the data from the txt file
data <- read.table("household_power_consumption.txt", 
                   header = TRUE, 
                   sep = ";", 
                   stringsAsFactors = FALSE,
                   na.strings = "?",  # Handle missing values coded as "?"
                   )

# Check the first few rows of the data
head(data)

# Subset data to only include the required dates
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- data[data$Date %in% as.Date(c("2007-02-01", "2007-02-02")), ]

head(data)
data$Datetime <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

# Drop the original Date and Time columns (optional)
data$Date <- NULL
data$Time <- NULL

# Display the structure of the data to see the column types
str(data)

data$Global_active_power  <-as.numeric(data$Global_active_power)
data$Global_reactive_power  <-as.numeric(data$Global_reactive_power)
data$Voltage                <-as.numeric(data$Voltage    )
data$Global_intensity <-as.numeric(data$Global_intensity  )
data$Sub_metering_1 <-as.numeric(data$Sub_metering_1  )
data$Sub_metering_2 <-as.numeric(data$Sub_metering_2  )
data$Sub_metering_3 <-as.numeric(data$Sub_metering_3  )

str(data)
# 'data.frame':	2880 obs. of  8 variables:
#   $ Global_active_power  : num  0.326 0.326 0.324 0.324 0.322 0.32 0.32 0.32 0.32 0.236 ...
# $ Global_reactive_power: num  0.128 0.13 0.132 0.134 0.13 0.126 0.126 0.126 0.128 0 ...
# $ Voltage              : num  243 243 244 244 243 ...
# $ Global_intensity     : num  1.4 1.4 1.4 1.4 1.4 1.4 1.4 1.4 1.4 1 ...
# $ Sub_metering_1       : num  0 0 0 0 0 0 0 0 0 0 ...
# $ Sub_metering_2       : num  0 0 0 0 0 0 0 0 0 0 ...
# $ Sub_metering_3       : num  0 0 0 0 0 0 0 0 0 0 ...
# $ Datetime             : POSIXlt, format: "2007-02-01 00:00:00" "2007-02-

library(ggplot2)
ggplot(data, aes(x = Global_active_power)) +
  geom_histogram(fill = "red", color="black", bins = 12) +
  ggtitle("Global Active Power") +
  xlab("Global Active Power (kilowatts)")+
  ylab("Frequency") +  # Set the y-axis label to "Frequency"
  xlim(0, 6)  +  # Set the x-axis limit from 0 to 6
  theme(plot.title = element_text(hjust = 0.5))  # Center the main title
