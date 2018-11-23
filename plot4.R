source("getData.R")
library(ggplot2)
#library(stringr)
# loading data

data <- inner_join(select(scc[grep("coal", scc$SCC.Level.Three, ignore.case = TRUE),], 1:3), 
                  pm25)
#define median per year
med <- as.tbl(data) %>%
        group_by(yearf, year) %>%
        summarise(medEm = median(Emissions), medLogEm = median(logEm))

#data <- subset(data, !is.na(data))
g <- ggplot(data, aes(year, logEm))

sol <- g+ geom_point(color = "steelblue", size = 3, alpha = 1/2) + 
        geom_line(mapping = aes(year, median(logEm)), 
                  color = "black", linetype = 4, size = 1) + 
        geom_line(aes(year, medLogEm), 
                  color = "red", data = med) + 
        labs(y = expression("log " * PM[2.5])) + 
        ggtitle("Carbon emissions in the US")

png("plot4.png", width = 720, height = 480)
print(sol)
dev.off()
