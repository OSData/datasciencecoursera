# read manually subsetted file
set <- read.table("household_power_consumption_subset.txt", header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)

# or use next lines to read / subset dataset via sqldf
# require(sqldf)
# file <- c("household_power_consumption.txt")
# set <- read.csv.sql(file, header = T, sep=";", sql = "select * from file where (Date == '1/2/2007' OR Date == '2/2/2007')" )

# create column DateTime
set$DateTime<-strptime(paste(set$Date,set$Time), format="%d/%m/%Y %H:%M:%S")

# convert to date
set$Date <- as.Date(set$Date, format="%d/%m/%Y")

# set locale
Sys.setlocale("LC_TIME", "English")

# plot2
png(file="plot2.png", width = 480, height = 480,bg = "transparent")
plot(set$DateTime,set$Global_active_power,type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()