library(tidyverse)
library(lubridate)
library(dplyr)
library(readr)


# Create data directory 


if(!dir.exists("data")) { dir.create("data") } 
# Download and unzip data file 


file.url   <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
file.path  <- "data/household_power_consumption.zip" 
file.unzip <- "data/household_power_consumption.txt" 


if(!file.exists(file.path) & !file.exists(file.unzip)) { 
download.file(file.url, file.path) 
unzip(file.path, exdir = "data") 
}

# Load data from 2007-02-01 to 2007-02-02 


data <- read_delim("household_power_consumption.txt", 
delim = ";", 
na    = c("?"), 
col_types = list(col_date(format = "%d/%m/%Y"), 
col_time(format = ""), 
col_number(), 
col_number(), 
col_number(), 
col_number(), 
col_number(), 
col_number(), 
col_number())) %>% 
filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02"))) 


# Make Plot --------------------------------------------------------------- 
data <- mutate(data, datetime = ymd_hms(paste(Date, Time)))

plot(Global_active_power ~ datetime, data, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = NA)

# Save Plot ---------------------------------------------------------------
dev.copy(png, "plot2.png",
         width  = 480,
         height = 480)
dev.off()
