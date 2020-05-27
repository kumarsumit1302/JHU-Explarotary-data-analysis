source_description <- readRDS("Source_Classification_Code.rds")
source_data <- readRDS("summarySCC_PM25.rds")


motor_index <- grep("Motor",source_description$Short.Name)
scc_number <- source_description$SCC[motor_index]
scc_index <- which(source_data$SCC %in% scc_number)


motor_df <- source_data[scc_index,]
motor_baltimore_df <- subset(motor_df,fips=="24510")
motor_losangeles_df <- subset(motor_df,fips=="06037")

motor_melt_baltimore_df <- melt(motor_baltimore_df,id="year",measure.vars = "Emissions")
motor_baltimore_sum_df <- dcast(motor_melt_baltimore_df,year~variable,sum)

motor_melt_losangeles_df <- melt(motor_losangeles_df,id="year",measure.vars = "Emissions")
motor_losangeles_sum_df <- dcast(motor_melt_losangeles_df,year~variable,sum)

compare_df <- rbind(motor_baltimore_sum_df,motor_losangeles_sum_df)
compare_df$county <- c(rep("baltimore",4),rep("Los Angeles",4))


png("plot6.png")
p6 <- ggplot(compare_df,aes(year,Emissions))
p6+geom_point()+geom_line()+geom_smooth(method = "lm")+facet_grid(.~county)+labs(title = "Baltimore and Los angeles")
dev.off()














