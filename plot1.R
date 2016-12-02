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

# Plot 1
png(filename = "plot1.png",
    width = 480, height = 480, units = "px")
with(mydf, 
     hist(Global_active_power, freq = T,
          main = "Global Active Power",
          col = "red")
)

dev.off()

