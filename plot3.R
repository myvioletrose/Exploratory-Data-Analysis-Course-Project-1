initial <- read.table(file.choose(), 
                      nrow = 100, 
                      na.strings = "?", 
                      sep = ";", 
                      stringsAsFactors = F, 
                      header = T)
classes <- sapply(initial, class)
tabAll <- read.table(file.choose(), 
                     colClasses = classes, 
                     na.strings = "?", 
                     sep = ";", 
                     stringsAsFactors = F, 
                     header = T)

library(lubridate)
tabAll$dateConvert <- dmy(tabAll$Date)
mydate <- c('2007-02-01', '2007-02-02')
mydate <- ymd(mydate)
mydf <- subset(tabAll, dateConvert %in% mydate) 
dim(mydf)
View(mydf)

# Plot 3
mydf$DateTime <- with(mydf, paste(Date, Time, sep=' '))
mydf$DateTime <- strptime(mydf$DateTime, format = "%d/%m/%Y %H:%M:%S")

png(filename = "plot3.png",
    width = 480, height = 480, units = "px")

with(mydf, 
     plot(DateTime, 
          Sub_metering_1, 
          type = "n",
          ylab = "Engergy Sub metering"
     )
)

with(mydf, 
     lines(DateTime, Sub_metering_1, type = "l", col = "black")
)
with(mydf, 
     lines(DateTime, Sub_metering_2, type = "l", col = "red")
)
with(mydf, 
     lines(DateTime, Sub_metering_3, type = "l", col = "blue")
)

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1,
       col = c("black", "red", "blue")
)

dev.off()
