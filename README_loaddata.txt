In the following, I explain my way of loading data.

Step 1. Open R, and use Misc (in Mac) or function setwd() to set a proper work directory. 
        Then download the dataset Electric power consumption, a zip file, to the work 
        directory of R. 
Step 2. Release this zip file and we will get a txt file named "household_power_consumption.txt".
        Check its size, which is 133 MB. 
Notes.  one can also use the functions download.file(fileUrl, destfile = "?") and unzip() to 
        do above two steps.
Step 3. Load the data.  
           3.1 Check the data.
               Read the first several lines, for example, 3 lines, to learn its format. Since we 
               were told the missing number are denoted by "?", set na.string = "?".

dir() # To find the name of required txt file
test <- read.table("household_power_consumption.txt", nrow = 3, na.strings = "?")

               After checking the result, we realize more settings are needed in read.table:
               header = TRUE, sep = ";"

test <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
 nrow = 3, na.strings = "?")
name <- names(test)

                We saved the column names of the data, as we will find that we need it later.
                Since we only need to use a data subset from the dates 2007-02-01 to 2007-02-02,
                one can use readLines() and grep("^([ ]{0, })0?[12]/[02,2]", readLines(), 
                value = TRUE) to filter the original dataset.
                So far, the data we've got miss column name. This is the reason we saved it before. 
Notes.     One can also try read.table() first, and then use the function filter() of 
           package dplyr to arrive above aims.  
            
            3.2 Fetch the data

con <- file("household_power_consumption.txt", "rt") # bulid up a connection
householdData <- read.table(text = grep("^([ ]{0, })0?[12]/[02,2]/2007", readLines(con),
 value =  TRUE), sep = ";", col.names = name, na.strings = "?")
close(con) # close the connection

Notes.     One can use dim(), str() to check the basic info of householdData.
           I've checked that some rows of the data starts with a several blank spaces. And we were
           not tell the format of Date is like 1/2/2007 or 01/02/2007.
