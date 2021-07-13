# Load data.table
library(data.table)
area <- fread("D:/R_data_analyst/Joining_data_data.table/aus_pop/australia_area.csv")
capitals <- fread("D:/R_data_analyst/Joining_data_data.table/aus_pop/australia_capitals.csv")
population <- fread("D:/R_data_analyst/Joining_data_data.table/aus_pop/australia_cities_top20.csv")
# Right join population to capitals using data.table syntax
capitals[population, on = .(city)]
# Right join using merge
merge(capitals, population, by = "city", all.y = TRUE)
# Inner join with the data.table syntax
capitals[population, on = "city", nomatch = FALSE]
# options(datatable.nomatch = 0)
# Anti-join capitals to population
population[!capitals, on = "city"]
# Anti-join capitals to area
area[!capitals, on = "state"]
######################################################
# Set the keys
setkey(netflix, "title")
setkey(imdb, "title")
# Inner join
netflix[imdb, nomatch = 0]
# Check for keys
haskey(netflix)
haskey(imdb)
# Find the key
the_key <- key(netflix)
# Set the key for the other data.table
setkeyv(imdb, the_key)
######################################################
# Inner join capitals to population
population[capitals, on = .(city), nomatch = 0]
# Join and sum
population[capitals, on = .(city), nomatch = 0,
           j = sum(percentage)]
life_exp <- fread("D:/R_data_analyst/Joining_data_data.table/life_expectancy/gapminder_life_expectancy_2010.csv")
continents <- fread("D:/R_data_analyst/Joining_data_data.table/life_expectancy/continents.csv")
# How many continents is each country listed in?
continents[life_exp, on = .(country), .N, 
           by = .EACHI]
# What countries are listed in multiple continents?
continents[life_exp, on = .(country), .N, 
           by = .EACHI][N > 1]
# Calculate average life expectancy per continent
avg_life_expectancy <- continents[life_exp, on = .(country), 
                                  nomatch = 0][, j = .(mean(years)), 
                                               by = .(continent)]
avg_life_expectancy