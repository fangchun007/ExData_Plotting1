#############################PART ONE Loading the data###############################
#### 1. Download the dataset Electric power consumption to the work file of R. Or use 
####    Misc (in Mac) or setwd() to set the work directory to the file of dataset.
#### 2. Release the zip file and get txt file named "household_power_consumption.txt".
####    Check its size, which is 133 MB. 
####    Or use download.file(fileUrl, destfile = "?") and then unzip()
#### 3. Load the data. 
##      3.1 Read the first 3 lines so that we can check the format of data. Set 
##          na.string = "?"

dir() # To find the name of required txt file
test <- read.table("household_power_consumption.txt", nrow = 3, na.strings = "?")

#           After checking the result, we can find we need to use more settings of 
#           read.table: header = TRUE, sep = ";"

test <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
 nrow = 3, na.strings = "?")
name <- names(test)

#           Since we only need the data subset from the dates 2007-02-01 to 2007-02-02,
#           we can use readLines() and grep("^([ ]{0, })0?[12]/[02,2]", readLines(), 
#           value = TRUE) to filter the original dataset.
#           One can also try read.table() first, and then use the filter() function of 
#           package dplyr           
##      3.2 Fetch the data

con <- file("household_power_consumption.txt", "rt") # bulid up connection
householdData <- read.table(text = grep("^([ ]{0, })0?[12]/[02,2]/2007", readLines(con),
 value =  TRUE), sep = ";", col.names = name, na.strings = "?")
close(con) # close the connection

# one can use dim(), str() to check the basic info of householdData.

##############################PART TWO Making Plots###################################

#### Plot 4

par(mfrow = c(2, 2), mar = c(4, 4, 2, 2 ))
with(householdData, {
    plot(DateTime, Global_active_power, type = "l", 
      xlab = " ", ylab = "Global Active Power")
    plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
    plot(DateTime, Sub_metering_1, type = "l", xlab = " ", ylab = "Energy sub metering")
    lines(DateTime, Sub_metering_2, col = "red")
    lines(DateTime, Sub_metering_3, col = "blue")
    legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"), legend =
      c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime")
 })

dev.copy(png, file = "plot4.png",  width = 480, height = 480, units = "px")
dev.off()



