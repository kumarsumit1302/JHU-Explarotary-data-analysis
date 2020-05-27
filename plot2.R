source_description <- readRDS("Source_Classification_Code.rds")
source_data <- readRDS("summarySCC_PM25.rds")

source_baltimore <- subset(source_data,fips==24510)
PM2.5_baltimore_sum <- with(source_baltimore,tapply(Emissions,year,sum))
PM2.5_baltimore_df <- data.frame(year=c(1999,2002,2005,2008),total_PM2.5=PM2.5_baltimore_sum,row.names = NULL)

png("plot2.png")
with(PM2.5_baltimore_df,plot(year,total_PM2.5,type = "o",col="red",main = "Emission_Baltimore City"))
dev.off()
