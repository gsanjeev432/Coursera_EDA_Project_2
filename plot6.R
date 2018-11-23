source("getData.R")
library(ggplot2)
# Los Angeles County, California (fips == "06037")
# Baltimore City, Maryland (fips == "24510")
city <- data.frame(fips = c("06037", "24510") , 
                   city = c("Los Angeles County", "Baltimore City"), 
                   stringsAsFactors = F) # small df to join for geting city name instead of fip
#pm25 <- pm25 %>%
#        filter(fips == "24510" | fips == "06037") #we filter
        
pm25 <- left_join(city, pm25) # no need to filter as left join will take care of it
pm25$city <- as.factor(pm25$city)

#final data set with city, vehicle and emissions
data <- inner_join(select(scc[grep("Mobile Sources", scc$SCC.Level.One, ignore.case = TRUE),], 
                          1:3),
                pm25)
g <- qplot(yearf, logEm, data = data, 
           geom = "boxplot", 
           col = city)
g <- g + labs(x = "Year",
         y = expression("log " * PM[2.5]),
         colour = "Vehicle Emission by city")

png("plot6.png", width = 720, height = 540)
print(g)
dev.off()