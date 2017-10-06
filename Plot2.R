## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# With command line mode, we have confirmed that Emisison column does not have NA. 
# Data contains 4 years of data that is of our interest.

# Filter Baltimore Data
NEI_Baltimore <- NEI[NEI$fips=="24510",]

# Index by Year, perform sum of emission from all sources to get total Emission in an year
x<- with(NEI_Baltimore, tapply(Emissions, year, FUN=sum))

# We will convert it kilo Unit scale to make Y axis better
x <- x/1000

png(filename = "Plot2.png",width = 480, height = 480, units = "px", pointsize = 12,bg = "white", res = NA, family = "", 
    restoreConsole = TRUE,type = c("windows", "cairo", "cairo-png"))

#BarPlot
barplot(x, main="Total Yearly Emissions of Baltimore", ylab="Kilo Units", xlab = "Year")

dev.off()
