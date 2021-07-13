# Load data.table
library(data.table)
# import imbd and netflix
imdb <- fread("D:/R_data_analyst/Joining_data_data.table/imbd_ratings.csv")
netflix <- fread("D:/R_data_analyst/Joining_data_data.table/netflix_2017.csv")
# What data.tables are in my R session?
# tables()
# View the first six rows 
head(netflix, n = 6)
head(imdb, n = 6)
# Print the structure
str(netflix)
str(imdb)
##################################################
# Inner join netflix and imdb
merge(netflix, imdb, by = "title")
# Full join netflix and imdb
merge(netflix, imdb, by = "title", all = TRUE)
# Full join imdb and netflix
merge(imdb, netflix, by = "title", all = TRUE)
##################################################
# Left join imdb to netflix
merge(x = netflix, y = imdb, by = "title", all.x = TRUE)
# Right join imdb to netflix
merge(x = netflix, y = imdb, by = "title", all.y = TRUE)
# Compare to a left join of netflix to imdb
merge(x = imdb, y = netflix, by = "title", all.x = TRUE)
# Identify the key for joining capitals and population
# capitals_population_key <- "city"
# Left join population to capitals
# capital_pop <- merge(x = capitals, y = population, by = capitals_population_key, all.x = TRUE)
# capital_pop
# Identify the key for joining capital_pop and area
# capital_pop_area_key <- "state"
# Inner join area to capital pop
# australia_stats <- merge(capital_pop, area, by = capital_pop_area_key)
# Print the final result
# australia_stats