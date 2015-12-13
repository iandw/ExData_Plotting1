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

#Generate plot1.png (480x480)
#This plot should be a histogram of global active power
#It should be titled "Global Active Power"
#The x-axis label should say "Global Active Power (kilowatts)"
#The bars should be colored orange.
png(filename="./plot1.png",
    width=480,
    height=480)

hist(hh_pwr_consumption_subset$Global_active_power,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     col="orangered1") 

dev.off()

