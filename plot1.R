plot1 <- function() {
  #Load datas from household_power
  data  <-   read.table(file = "household_power_consumption.txt",
                        sep = ";", na.strings ="?", colClasses =  c("character", "character","numeric",
                                                                    "numeric", "numeric", "numeric",
                                                                    "numeric", "numeric", "numeric"),
                        skip = 1440*46, nrows = 1440*5, col.names = c("Date", "Time","Global_active_power",
                                                                      "Global_reactive_power", "Voltage", "Global_intensity",
                                                                      "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  #data[,2] <- as.POSIXct(paste(data[,1], data[,2], sep = " "), format ="%d/%m/%Y %H:%M:%s")
  data[,2] <- paste(data[,1], data[,2], sep = " ")
  data[,2]  <- as.POSIXct(strptime(data[,2], format = "%d/%m/%Y %H:%M:%S"))
  data[,1]  <- as.Date(data[,1], format="%d/%m/%Y")
  
  #Filtering data to datad
  f  <-  data[,1] =="2007-02-01" | data[,1] =="2007-02-02"
  data  <- data[f,]
  
  png ( filename = "plot1.png", width = 480, height = 480)
  hist(data$Global_active_power, col ="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
  dev.off()
}