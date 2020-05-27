source_description <- readRDS("Source_Classification_Code.rds")
source_data <- readRDS("summarySCC_PM25.rds")

coal_index <- grep("Coal",source_description$Short.Name)
scc_number <- source_description$SCC[coal_index]
scc_index <- which(source_data$SCC %in% scc_number)


coal_df <- source_data[scc_index,]
melt_df <- melt(coal_df,id="year",measure.vars = "Emissions")
coal_emission_df <- dcast(melt_df,year~variable,sum)

png("plot4.png")
p4 <- ggplot(coal_emission_df,aes(year,Emissions))
p4+geom_point()+geom_line()+geom_smooth(method = "lm")+labs(title = "Emission from Coal Sources")
dev.off()
