library(dplyr)
library(ggplot2)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# With command line mode, we have confirmed that Emisison column does not have NA. 
# Data contains 4 years of data that is of our interest.

# Filter Coal Data
coal_filter <- grepl("[c,C]oal", SCC$Short.Name) | grepl("[c,C]oal", SCC$EI.Sector)
coal_src <- SCC[coal_filter,"SCC"]

# Index by Year, perform sum of emission from all coal sources to get total Emission in an year
x <- NEI %>% filter(SCC %in% coal_src) %>% group_by(year) %>% summarize(Emission=sum(Emissions))

p <- ggplot(x, aes(year, Emission )) + geom_point() + geom_smooth() + labs(title = "Emission From Coal Combustion Sources")

png(filename = "Plot4.png",width = 960, height = 480, units = "px", pointsize = 12,bg = "white", res = NA, family = "", 
    restoreConsole = TRUE,type = c("windows", "cairo", "cairo-png"))

print(p)

dev.off()
