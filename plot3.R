library(lubridate)
# input file
input_file<-'household_power_consumption.txt'
# output plot
filename<-"plot3.png"
if (!file.exists(input_file)) {
  downurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(downurl,"exdata-data-household_power_consumption.zip","curl")
  unzip('exdata-data-household_power_consumption.zip')
}

eusage<-read.csv2('household_power_consumption.txt')

#filter for days:  2007-02-01 and 2007-02-02.
date1<-as.POSIXct("2007-02-01;00:00:00")
date2<-as.POSIXct("2007-02-03;00:00:00")

# filtered dataset euse
euse<-with(eusage, 
           eusage[strptime(paste0(eusage$Date,";",eusage$Time),"%d/%m/%Y;%H:%M:%S") 
                  >= date1 & strptime(paste0(eusage$Date,";",eusage$Time),"%d/%m/%Y;%H:%M:%S") < date2, ])

#plot 3; sub_metering 1-3 vs time
#Construct the plot and save it to a PNG file with 
#a width of 480 pixels and a height of 480 pixels. (default resolution)

png(filename=filename, width=480, height=480)

plot(strptime(paste0(euse$Date,";",euse$Time),"%d/%m/%Y;%H:%M:%S"),
     as.numeric(as.character(euse$Sub_metering_1)),type="l",xlab="",
     ylab="Energy sub metering")
lines(strptime(paste0(euse$Date,";",euse$Time),"%d/%m/%Y;%H:%M:%S"),
      as.numeric(as.character(euse$Sub_metering_2)),type="l",col="red")
lines(strptime(paste0(euse$Date,";",euse$Time),"%d/%m/%Y;%H:%M:%S"),
      as.numeric(as.character(euse$Sub_metering_3)),type="l",col="blue")
# add a legend 
legend("topright", 
       c("Sub_metering1","Sub_metering2","Sub_metering3"), 
       lty=c(1,1),lwd=c(2.5,2.5),col=c("black","red","blue"))

dev.off()
