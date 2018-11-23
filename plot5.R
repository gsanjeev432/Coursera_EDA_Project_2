source("getData.R")
library(ggplot2)
#library(stringr)
# Baltimore City, Maryland (fips == "24510")
pm25 <- filter(pm25, fips == "24510")
data <- inner_join(select(scc[grep("Mobile Sources", scc$SCC.Level.One, ignore.case = TRUE),], 1:3), 
                   pm25)

sol <- qplot(yearf, logEm, data = data, geom = "boxplot") + 
        labs(y = expression("log " * PM[2.5]), x = "Year") +
        ggtitle("Vehicle emissions in Baltimore")
print(sol)
# now we create the graph
png("plot5.png", width = 720, height = 480 )
        print(sol)
dev.off()