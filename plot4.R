plot4 <- function() {
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
  
  #Filtering data to suitable dates
  f  <-  data[,1] =="2007-02-01" | data[,1] =="2007-02-02"
  data  <- data[f,]
  
  
  png ( filename = "plot4.png", width = 480, height = 480)
  
  par(mfrow=c(2,2))
  
  #Plot 1,1
  plot(data$Time,data$Global_active_power, type = "n", xlab = "", ylab ="Global Active Power")
  lines(data$Time,data$Global_active_power)
  
  #Plot 1,2
  plot(data$Time,data$Voltage, type = "n", xlab = "datetime", ylab ="Voltage")
  lines(data$Time,data$Voltage)
  
  #Plot 2,1
  plot(data$Time,data$Sub_metering_1, type = "n", xlab = "", ylab ="Energy sub metering")
  
  #Ploting lines
  lines(data$Time,data$Sub_metering_1)
  lines(data$Time,data$Sub_metering_2, col = "red")
  lines(data$Time,data$Sub_metering_3, col = "blue")
  
  #Adding legend 
  legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
         lty = 1, col = c("black", "red", "blue"), bty = "n")
  
  #Plot 2,2
  plot(data$Time,data$Global_reactive_power, type = "n", xlab = "datetime", ylab ="Global_reactive_power")
  lines(data$Time,data$Global_reactive_power)
  
  
  #Saving
  dev.off()
}