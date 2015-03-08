ColumnNames <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

#set path to where the source data is here:
FilePath <- "~/Dropbox/Public/Coursera/Exploratory Data Analysis/Week 1/Household Power/household_power_consumption.txt"

#slow way
#household_power_consumption <- read.csv(FilePath,
#                                        colClasses = c('myDate', 'character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'),
#                                        header = TRUE,
#                                        sep = ";",
#                                        na.strings = c("?"))
#household_power_consumption <- household_power_consumption[household_power_consumption$Date == as.Date("2007-02-01") | household_power_consumption$Date == as.Date("2007-02-02"),]

#fast way
household_power_consumption <- read.csv(FilePath,
                                        colClasses = c('character', 'character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'),
                                        col.names = ColumnNames,
                                        sep = ";",
                                        na.strings = c("?"),
                                        skip = 66636,
                                        nrows = 2880)

#create a new column for data and time together
household_power_consumption$DateTime <- strptime(paste(household_power_consumption$Date, household_power_consumption$Time), "%d/%m/%Y %H:%M") 

#Set up png file as graphics device
png("plot4.png", width=480, height=480, units="px")

#Set up sub plots
par(mfrow=c(2,2))

#first plot
plot(household_power_consumption$DateTime,
     household_power_consumption$Global_active_power,
     type="l",
     ylab="Global Active Power",
     xlab = "")

#second plot
plot(household_power_consumption$DateTime,
     household_power_consumption$Voltage,
     type="l",
     ylab="Voltage",
     xlab = "datetime")

#third plot

# Define colours to be used 
plot_colours <- c("black", "red", "blue")

#Base plot
plot(household_power_consumption$DateTime,
     household_power_consumption$Sub_metering_1,
     col=plot_colours[1],
     type="l",
     ylab="Energy sub metering",
     xlab = "")

#sub metering 2
lines(household_power_consumption$DateTime,
      household_power_consumption$Sub_metering_2,
      col=plot_colours[2],
      type="l")

#sub metering 3
lines(household_power_consumption$DateTime,
      household_power_consumption$Sub_metering_3,
      col=plot_colours[3],
      type="l")

#Legend
legend("topright",
       legend=names(household_power_consumption[,7:9]),
       col=plot_colours,
       lwd=2,
       bty = "n")

#fourth plot
plot(household_power_consumption$DateTime,
     household_power_consumption$Global_reactive_power,
     type="l",
     ylab="Global_reactive_power",
     xlab = "datetime")

dev.off()