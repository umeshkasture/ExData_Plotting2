library(dplyr)
library(ggplot2)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# With command line mode, we have confirmed that Emisison column does not have NA. 
# Data contains 4 years of data that is of our interest.

# Filter Motor Vehicle Data
mv_filter <- grepl("[M,m]otor", SCC$Short.Name) | grepl("[V,v]eh", SCC$Short.Name)
mv_src <- SCC[mv_filter,"SCC"]

# Filter Baltimore Data
# Index by Year, perform sum of emission from all sources to get total Emission in an year
x <- NEI %>% filter((fips == "24510")|(fips == "06037")) %>% 
    filter(SCC %in% mv_src) %>% group_by(year, fips) %>% 
    summarize(Emission=sum(Emissions))

p <- ggplot(x, aes(year, Emission )) + facet_grid(. ~ fips) + geom_point() + geom_smooth() + labs(title = "Emission From Motor Vehicle Sources Los Angeles County Vs Baltimore City")

png(filename = "Plot6.png",width = 960, height = 480, units = "px", pointsize = 12,bg = "white", res = NA, family = "", 
    restoreConsole = TRUE,type = c("windows", "cairo", "cairo-png"))

print(p)

dev.off()
