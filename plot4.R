#Read in the data
data_file <- "C:/Users/Katelyn/Desktop/Data_For_EDA_Project_1/household_power_consumption.txt"
hh_pwr_consumption <- read.table(data_file,
                   header=TRUE,
                   sep=";",
                   na.strings="?",
                   colClasses=c("character",
                                "character",
                                "numeric",
                                "numeric",
                                "numeric",
                                "numeric",
                                "numeric",
                                "numeric",
                                "numeric")
                   )

#Clean workspace
rm(data_file)

#Change the Date column from character to Date (original format = dd/mm/yyyy)
hh_pwr_consumption$Date <- as.Date(hh_pwr_consumption$Date, "%d/%m/%Y")

#Subset the data to be only dates between 2007-02-01 and 2007-02-02
hh_pwr_consumption_subset <- hh_pwr_consumption[hh_pwr_consumption$Date >= '2007-02-01' & hh_pwr_consumption$Date <= '2007-02-02',]

#Remove the original data set
rm(hh_pwr_consumption)

#Create a new column that is the date and timestamp together (character format)
hh_pwr_consumption_subset$datetime_character_string <- paste(as.character(hh_pwr_consumption_subset$Date), hh_pwr_consumption_subset$Time, sep=" ")

#Convert this to datetime using strptime 
hh_pwr_consumption_subset$datetime <- as.POSIXct(strptime(hh_pwr_consumption_subset$datetime_character_string, "%Y-%m-%d %H:%M:%S"))

#Remove the datetime_character_string column
hh_pwr_consumption_subset$datetime_character_string <- NULL

#Generate plot4.png (480x480)
png(filename="./plot4.png",
    width=480,
    height=480)

#We want 4 plots in a matrix of 2 rows and 2 columns, which we'll fill column-wise
par(mfcol=c(2,2))

#Generate plot in row 1 column 1 
plot(hh_pwr_consumption_subset$datetime, 
     hh_pwr_consumption_subset$Global_active_power, 
     type="n",
     xlab="",
     ylab="Global Active Power")
lines(hh_pwr_consumption_subset$datetime, 
      hh_pwr_consumption_subset$Global_active_power)

#Generate plot in row 2 column 1 
plot(hh_pwr_consumption_subset$datetime, 
     hh_pwr_consumption_subset$Sub_metering_1,
     type="n",
     xlab="",
     ylab="Energy sub metering")

#Plot lines for Sub_metering_1 in black
lines(hh_pwr_consumption_subset$datetime,
      hh_pwr_consumption_subset$Sub_metering_1,
      col="black")

#Plot lines for Sub_metering_2 in red
lines(hh_pwr_consumption_subset$datetime, 
      hh_pwr_consumption_subset$Sub_metering_2,
      col="red")

#Plot lines for Sub_metering_3 in blue
lines(hh_pwr_consumption_subset$datetime,
      hh_pwr_consumption_subset$Sub_metering_3,
      col="blue")

legend("topright", 
       legend=c("Sub_metering_1", 
                "Sub_metering_2",
                "Sub_metering_3"),
       lty=c(1,1,1),
       bty="n",
       col=c("black", "red", "blue"))


#Generate plot in row 1 column 2
plot(hh_pwr_consumption_subset$datetime,
     hh_pwr_consumption_subset$Voltage,
     type="n",
     xlab="datetime",
     ylab="Voltage")
lines(hh_pwr_consumption_subset$datetime,
     hh_pwr_consumption_subset$Voltage)

#Generate plot in row 2 column 2
plot(hh_pwr_consumption_subset$datetime,
     hh_pwr_consumption_subset$Global_reactive_power,
     type="n",
     xlab="datetime",
     ylab="Global_reactive_power")

lines(hh_pwr_consumption_subset$datetime,
      hh_pwr_consumption_subset$Global_reactive_power,
      lwd=0.25)

#Turn the graphics device off
dev.off()


