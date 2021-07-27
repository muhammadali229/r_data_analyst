library(stringdist)
library(fuzzyjoin)
library(reclin)
library(dplyr)
# Calculate Damerau-Levenshtein distance
stringdist("las angelos","los angeles" , method = "dl")
# Calculate LCS distance
stringdist("las angelos", "los angeles", "lcs")
# Calculate Jaccard distance
stringdist("las angelos", "los angeles", method = "jaccard")
# LCS distance only uses insertion and deletion, 
# so it takes more operations to change a string to another.
################################################################
zagat <- readRDS("D:/R_data_analyst/Cleaning_Data/zagat.rds")
fodors <- readRDS("D:/R_data_analyst/Cleaning_Data/fodors.rds")
cities <- data.frame(city_actual = c( "new york", "los angeles", "atlanta", "san francisco", "las vegas"))
# Count the number of each city variation
zagat %>%
  count(city)
# Join zagat and cities and look at results
zagat %>%
  # Left join based on stringdist using city and city_actual cols
  stringdist_left_join(cities, by = c("city" = "city_actual")) %>%
  # Select the name, city, and city_actual cols
  select(name, city, city_actual)
################################################################
# Generate all possible pairs
pair_blocking(zagat, fodors)


################################################################



################################################################



################################################################