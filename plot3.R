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

#Generate plot3.png (480x480)
png(filename="./plot3.png",
    width=480,
    height=480)

#Initialize an empty plot with the Sub_metering_1 data (which is 0 to 38)
#Chose this data because the other 2 columns (Sub_metering_2 and _3 fall in this range)

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
col=c("black", "red", "blue"))

#Turn the graphics device off
dev.off()

