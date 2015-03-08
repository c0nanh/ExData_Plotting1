ColumnNames <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

#set path to where the source data is here:
FilePath <- "~/Dropbox/Public/Coursera/Exploratory Data Analysis/Week 1/Household Power/household_power_consumption.txt"

#slow way
#household_power_consumption <- read.csv(FilePath,
#                                        colClasses = c('myDate', 'myTime','numeric','numeric','numeric','numeric','numeric','numeric','numeric'),
#                                        header = TRUE,
#                                        sep = ";",
#                                        na.strings = c("?"))
#household_power_consumption <- household_power_consumption[household_power_consumption$Date == as.Date("2007-02-01") | household_power_consumption$Date == as.Date("2007-02-02"),]

#fast way
household_power_consumption <- read.csv(FilePath,
                                        colClasses = c('myDate', 'myTime','numeric','numeric','numeric','numeric','numeric','numeric','numeric'),
                                        col.names = ColumnNames,
                                        sep = ";",
                                        na.strings = c("?"),
                                        skip = 66636,
                                        nrows = 2880)

#create a new column for data and time together
household_power_consumption$DateTime <- strptime(paste(household_power_consumption$Date, household_power_consumption$Time), "%d/%m/%Y %H:%M") 

png("plot1.png", width=480, height=480, units="px")

hist(household_power_consumption$Global_active_power,
     col="red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.off()