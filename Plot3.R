source_description <- readRDS("Source_Classification_Code.rds")
source_data <- readRDS("summarySCC_PM25.rds")


baltimore_data <- subset(source_data,fips==24510)
melt_data <- melt(baltimore_data,id=c("year","type"),measure.vars = "Emissions")
Baltimore_df <- dcast(melt_data,year+type~variable,sum)

png("plot3.png")
p3 <- ggplot(Baltimore_df,aes(year,Emissions))
p3+geom_point()+facet_grid(.~type)+geom_smooth(method="lm")+labs(title = "Baltimore City Emission plot")
dev.off()
