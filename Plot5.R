source_description <- readRDS("Source_Classification_Code.rds")
source_data <- readRDS("summarySCC_PM25.rds")


motor_index <- grep("Motor",source_description$Short.Name)
scc_number <- source_description$SCC[motor_index]
scc_index <- which(source_data$SCC %in% scc_number)


motor_df <- source_data[scc_index,]
motor_baltimore_df <- subset(motor_df,fips=="24510")

motor_melt_df <- melt(motor_baltimore_df,id="year",measure.vars = "Emissions")
motor_baltimore_sum_df <- dcast(motor_melt_df,year~variable,sum)


png("plot5.png")
p5 <- ggplot(motor_baltimore_sum_df,aes(year,Emissions))
p5+geom_point()+geom_line()+geom_smooth(method = "lm")+labs(title = "Emission from Motor Vehicle in Baltimore City")
dev.off()
