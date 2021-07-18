# Load the readr package
library(readr)
library(readxl)
library(gdata)
# Import the csv file: pools
url_csv <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/swimming_pools.csv"
pools <- read_csv(url_csv)
# Import the txt file: potatoes
url_delim <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/potatoes.txt"
potatoes <- read_tsv(url_delim)
# Print pools and potatoes
pools
potatoes
###################################################
# https URL to the swimming_pools csv file.
url_csv <- "https://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/swimming_pools.csv"
# Import the file using read.csv(): pools1
pools1 <- read.csv(url_csv)
# Import the file using read_csv(): pools2
pools2 <- read_csv(url_csv)
# Print the structure of pools1 and pools2
str(pools1)
str(pools2)
###################################################
# Specification of url: url_xls
url_xls <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/latitude.xls"
# Import the .xls file with gdata: excel_gdata
# excel_gdata <- read.xls(url_xls)
# Download file behind URL, name it local_latitude.xls
# file <- download.file(url_xls, "D:/R_data_analyst/Intermediate_Importing_Data_R/local_latitude.xls")
# Import the local .xls file with readxl: excel_readxl
excel_readxl <- read_excel("D:/R_data_analyst/Intermediate_Importing_Data_R/local_latitude.xls")
excel_readxl
###################################
# URL pointing to the .csv file
url_csv <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/water.csv"
# Import the .csv file located at url_csv
water <- read.csv(url_csv, stringsAsFactor = FALSE)
# Convert the data file according to the requirements
water_json <- toJSON(water)
# Print out water_json
water_json
###################################
# Convert mtcars to a pretty JSON: pretty_json
pretty_json <- toJSON(mtcars, pretty = TRUE)
# Print pretty_json
pretty_json
# Minify pretty_json: mini_json
mini_json <- minify(pretty_json)
# Print mini_json
mini_json