source("getData.R")
# Baltimore City, Maryland (fips == "24510")
med <- as.tbl(pm25) %>%
        filter(fips == "24510") %>%
        select(year = yearf, Emissions, logEm) %>%
        group_by(year) %>%
        summarise(medEm = median(Emissions), medLogEm = median(logEm))

with(subset(pm25, fips == "24510"), {
        boxplot(logEm ~ year, pch = 19, outline = T) #we put box using Log, the lower the better
})
lines(med$year, y = med$medLogEm, col = "blue" , lwd = 1)
title(main = expression('PM'[25]*' emissions by year'), 
      sub = "Baltimore City, Maryland",
      ylab = "Log(Emissions)", 
      xlab= "Year")
# now to create the PNG plot, i chose to recreate insted of dev.copy
png("plot2.png", width = 600, height = 600)
        {with(subset(pm25, fips == "24510"), {
                boxplot(logEm ~ year, pch = 19, outline = T) #we put box using Log, the lower the better
        })
        lines(med$year, y = med$medLogEm, col = "blue" , lwd = 1)
        title(main = expression('PM'[25]*' emissions by year'), 
              sub = "Baltimore City, Maryland",
              ylab = "Log(Emissions)", 
              xlab= "Year")      
}
dev.off()
