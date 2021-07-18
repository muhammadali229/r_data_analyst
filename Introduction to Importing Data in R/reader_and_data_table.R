# Load the readr package
library(readr)
# load the data.table package using library()
library(data.table)
# Import potatoes.csv with read_csv(): potatoes
potatoes <- read_csv("D:/R_data_analyst/Introduction to Importing Data in R/potatoes.csv")
str(potatoes)
#############################
# Column names
properties <- c("area", "temp", "size", "storage", "method",
                "texture", "flavor", "moistness")
# Import potatoes.txt: potatoes
potatoes <- read_tsv("D:/R_data_analyst/Introduction to Importing Data in R/potatoes_1.txt", col_names = properties)
# Call head() on potatoes
head(potatoes)
#############################
# Column names
properties <- c("area", "temp", "size", "storage", "method",
                "texture", "flavor", "moistness")
# Import potatoes.txt using read_delim(): potatoes
potatoes <- read_delim("D:/R_data_analyst/Introduction to Importing Data in R/potatoes_1.txt", delim = "\t", col_names = properties)
# Print out potatoes
potatoes
#############################
# readr is already loaded

# Column names
properties <- c("area", "temp", "size", "storage", "method",
                "texture", "flavor", "moistness")

# Import 5 observations from potatoes.txt: potatoes_fragment
potatoes_fragment <- read_tsv("D:/R_data_analyst/Introduction to Importing Data in R/potatoes_1.txt", 
                              skip = 6, 
                              n_max = 5, 
                              col_names = properties)
potatoes_fragment
##############################
# Column names
properties <- c("area", "temp", "size", "storage", "method",
                "texture", "flavor", "moistness")
# Import all data, but force all columns to be character: potatoes_char
potatoes_char <- read_tsv("D:/R_data_analyst/Introduction to Importing Data in R/potatoes_1.txt", 
  col_types = "cccccccc", 
  col_names = properties)
# Print out structure of potatoes_char
str(potatoes_char)
##############################
# Import without col_types
hotdogs <- read_tsv("D:/R_data_analyst/Introduction to Importing Data in R/hotdogs.txt",
                    col_names = c("type", "calories", "sodium"))

# Display the summary of hotdogs
summary(hotdogs)

# The collectors you will need to import the data
fac <- col_factor(levels = c("Beef", "Meat", "Poultry"))
int <- col_integer()

# Edit the col_types argument to import the data correctly: hotdogs_factor
hotdogs_factor <- read_tsv("D:/R_data_analyst/Introduction to Importing Data in R/hotdogs.txt",
                           col_names = c("type", "calories", "sodium"),
                           col_types = list(fac, int, int))

# Display the summary of hotdogs_factor
summary(hotdogs_factor)
################################################
# Import potatoes.csv with fread(): potatoes
potatoes <- fread("D:/R_data_analyst/Introduction to Importing Data in R/potatoes.csv")
# Print out potatoes
potatoes
################################################
# Import columns 6 and 8 of potatoes.csv: potatoes
potatoes <- fread("potatoes.csv", 
                  select = c("texture", "moistness"))
# Plot texture (x) and moistness (y) of potatoes
plot(x = potatoes$texture, y = potatoes$moistness)