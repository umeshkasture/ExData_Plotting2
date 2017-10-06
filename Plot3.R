library(dplyr)
library(ggplot2)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# With command line mode, we have confirmed that Emisison column does not have NA. 
# Data contains 4 years of data that is of our interest.

# Filter Baltimore Data
# Index by Year, perform sum of emission from all sources to get total Emission in an year
x <- NEI %>% filter(fips == "24510") %>% group_by(year, type) %>% summarize(Emission=sum(Emissions))

p <- ggplot(x, aes(year, Emission, color = type)) + facet_grid(. ~ type) + geom_point() + geom_smooth() + labs(title = "Emission in Baltimore City from four types of sources")

png(filename = "Plot3.png",width = 960, height = 480, units = "px", pointsize = 12,bg = "white", res = NA, family = "", 
    restoreConsole = TRUE,type = c("windows", "cairo", "cairo-png"))

print(p)

dev.off()
