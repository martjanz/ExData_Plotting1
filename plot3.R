# load 10 lines of data
data <- read.table("data/household_power_consumption.txt",
                   header = TRUE,
                   sep = ";",
                   nrows = 10,
                   na.strings = '?')

# get column classes
colClasses <- sapply(data, class)

# read data
data <- read.table("data/household_power_consumption.txt",
                   header = TRUE,
                   sep = ";",
                   colClasses = colClasses,
                   na.strings = '?')

# Parse date/time into datetime and delete unnecesary columns
data$DateTime <- strptime(paste(as.character(data[,1]), as.character(data[,2])),
                          '%d/%m/%Y %H:%M:%S')

# Delete unnecessary columns 
data <- data[,3:10]

# Keep only records from 2007-02-01 and 2007-02-02
data <- data[as.Date(data$DateTime) >= as.Date('2007-02-01')
             & as.Date(data$DateTime) < as.Date('2007-02-03'),]


png(filename = "plot3.png",
    width = 480,
    height = 480)

plot(data$DateTime,
     data$Sub_metering_1,
     type = "s",
     ylab = "Energy sub metering",
     xlab = "")

lines(data$DateTime,
      data$Sub_metering_2, col = "red")

lines(data$DateTime,
      data$Sub_metering_3, col = "blue")

# Add legend
legend("topright", # position
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), # texts
       lty = c(1,1,1), # set lines
       col = c("black", "red", "blue")) # set lines colors

dev.off()