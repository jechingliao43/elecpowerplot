library(dplyr)

data <- read.table("household_power_consumption.txt", sep = ";")
names(data) <- data[1,]
data <- data[-1,]

select1 <- filter(data, Date == "1/2/2007")
select2 <- filter(data, Date == "2/2/2007")
data <- rbind(select1, select2)
rm(select1, select2)

data <- mutate(data, DateTime = paste0(Date, " ", Time), .after = Time)
data[[1]] <- NULL
data[[1]] <- NULL
data$DateTime<-strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
data[,c(2:8)]<-sapply(data[,c(2:8)], as.numeric)

png(file = "plot3.png")

plot(data$DateTime, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, type = "l", col = "red")
lines(data$DateTime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()