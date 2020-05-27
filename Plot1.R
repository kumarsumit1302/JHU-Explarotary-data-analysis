source_description <- readRDS("Source_Classification_Code.rds")
source_data <- readRDS("summarySCC_PM25.rds")

PM2.5_sum <- with(source_data,tapply(Emissions,year,sum))
PM2.5_sum_df <- data.frame(year=c(1999,2002,2005,2008),total_PM2.5=PM2.5_sum,row.names = NULL)

png("plot1.png")
with(PM2.5_sum_df,plot(year,total_PM2.5,col="red",type = "o",main = "Year Vs Total Emission"))
dev.off()
