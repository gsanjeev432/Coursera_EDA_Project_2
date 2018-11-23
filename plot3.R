source("getData.R")
library(ggplot2)
#Baltimore City, Maryland (fips == "24510")
#pm25 <- filter(pm25, fips == "24510") # subset 
#data <- filter(pm25, fips == "24510")

plot <- qplot(yearf, logEm, data = filter(pm25, fips == "24510"), 
      main = expression('Baltimore, PM'[25]*' emissions by type, year'),
      geom = "boxplot", 
      facets = . ~ type)

png("plot3.png", width = 960, height = 600)
        print(plot)
dev.off()