# Load data.table
library(data.table)
ebola_W50 <- fread("D:/R_data_analyst/Joining_data_data.table/ebola/ebola_2014_W50.csv")
ebola_W51 <- fread("D:/R_data_analyst/Joining_data_data.table/ebola/ebola_2014_W51.csv")
ebola_W52 <- fread("D:/R_data_analyst/Joining_data_data.table/ebola/ebola_2014_W52.csv")
gdp_table_files <- c("D:/R_data_analyst/Joining_data_data.table/gdp/gdp_africa_2000.csv",
         "D:/R_data_analyst/Joining_data_data.table/gdp/gdp_asia_2000.csv",
         "D:/R_data_analyst/Joining_data_data.table/gdp/gdp_europe_2000.csv",
         "D:/R_data_analyst/Joining_data_data.table/gdp/gdp_middle_east_2000.csv",
         "D:/R_data_analyst/Joining_data_data.table/gdp/gdp_north_america_2000.csv",
         "D:/R_data_analyst/Joining_data_data.table/gdp/gdp_oceania_2000.csv",
         "D:/R_data_analyst/Joining_data_data.table/gdp/gdp_south_america_2000.csv")
gdp_per_capita <- fread("D:/R_data_analyst/Joining_data_data.table/gdp/gdp_per_capita_oceania.csv")
gdp_oceania <- fread("D:/R_data_analyst/Joining_data_data.table/gdp/gdp_and_pop_oceania.csv")

gdp_by_industry_oceania <- fread("D:/R_data_analyst/Joining_data_data.table/gdp/gdp_by_industry_oceania.tsv")
names(gdp_table_files) <- c("africa",
                            "asia", 
                            "europe", 
                            "middle_east", 
                            "north_america", 
                            "oceania", "south_america")
# Concatenate case numbers from weeks 50 and 51
rbind(ebola_W50, ebola_W51)
str(ebola_W52)
str(ebola_W51)
str(ebola_W50)
# Modify the code
rbind(ebola_W50, ebola_W51, ebola_W52, fill = TRUE)
###################################################
gdp <- lapply(gdp_table_files, fread)
# Concatenate its data.tables
gdp_all_1 <- rbindlist(gdp)
gdp_all_1
# Concatenate its data.tables
gdp_all_2 <- rbindlist(gdp, idcol = "continent")
gdp_all_2
# Run this code to inspect gdp_all_2
gdp_all_2 <- rbindlist(gdp, idcol = "continent")
str(gdp_all_2)
gdp_all_2[95:105]
# Fix the problem
gdp_all_3 <- rbindlist(gdp, idcol = "continent", use.names = TRUE)
gdp_all_3
####################################################
# Obtain countries in both Asia and Europe
fintersect(gdp$asia, gdp$europe)
# Concatenate all data tables
gdp_all <- rbindlist(gdp)
####################################################
# Get all countries in either Asia or Europe
funion(gdp$asia, gdp$europe)
# Concatenate all data tables
gdp_all <- rbindlist(gdp)
# Print all unique countries
unique(gdp_all, by = "country")
# Find all countries that span multiple continents
gdp_all[duplicated(gdp_all, by = "country")]
# Which countries are in Africa but not considered part of the middle east?
fsetdiff(gdp$africa, gdp$middle_east)
# Which countries are in Asia but not considered part of the middle east?
fsetdiff(gdp$asia, gdp$middle_east)
# Which countries are in Europe but not considered part of the middle east?
fsetdiff(gdp$europe, gdp$middle_east)
##################################################
# Print gdp_per_capita
gdp_per_capita
# Reshape gdp_per_capita to the long format
melt(gdp_per_capita, id.vars = "year")
# Rename the new columns
melt(gdp_per_capita, id.vars = "year", 
     variable.name = "country", value.name = "gdp_pc")
#########################################
# Stack Week_50 and Week_51
# melt(ebola_wide, measure.vars = c("Week_50", "Week_51"), 
# variable.name = "period", value.name = "cases")
# Modify the code
# melt(ebola_wide, measure.vars = c("Week_50", "Week_51"), 
#      variable.name = "period", value.name = "cases", 
#      id.vars = "Location")
########################################
str(gdp_oceania)
# Split the population column by year
dcast(gdp_oceania, formula = country ~ year, value.var = "population")
# Split the gdp column by country
dcast(gdp_oceania, formula = year ~ country, value.var = "gdp")
########################################
# Split the gdp and population columns by year
dcast(gdp_oceania, formula = country ~ year, value.var = c("gdp", "population"))
# Reshape from wide to long format
wide <- dcast(gdp_oceania, formula = country ~ year, value.var = c("gdp", "population"))
# convert to a matrix
as.matrix(wide, rownames = "country")
# Modify your previous code
# dcast(gdp_oceania, formula = country + continent ~ year, value.var = c("gdp", "population"))
#########################################
# Split gdp by industry and year
gdp_by_industry_oceania
dcast(gdp_by_industry_oceania, country ~ industry + year, value.var = "gdp")