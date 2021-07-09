# Load data.table
library(data.table)
file_path <- "D:/R_data_analyst/Data Manipulation_data.table/sample.csv"
# Use read.csv() to import sample
system.time(read.csv(file_path))
# Use fread() to import sample
system.time(fread(file_path))
# Import using read.csv()
# csv_file <- read.csv("sample.csv", fill = NA, quote = "", 
#                      stringsAsFactors = FALSE, strip.white = TRUE, 
#                      header = TRUE)
# csv_file
# Import using fread()
csv_file <- fread(file_path)
csv_file
# Select "id" and "val" columns
select_columns <- fread(file_path, select = c("country", "sector"))
select_columns
# Drop the "val" column
drop_column <- fread(file_path, drop = "sector")
drop_column
# Import the file while providing only 3 rows
only_data <- fread(file_path, nrow = 3)
only_data
# Import the file while skipping 7 rows
only_metadata <- fread(file_path, skip = 7)
only_metadata
######################################################
ans <- fread("id, name\n1234567890123, Ali\n1234567890124, Zafar")
ans
class(ans$id)
s <- "x1,x2,x3,x4,x5\n1,2,1.5,true,cc\n3,4,2.5,false,ff"
ans <- fread(s, colClasses = c(x5 = "factor"))
str(ans)
######################################################
file_path_1 <- "D:/R_data_analyst/Data Manipulation_data.table/sample_1.csv"
# Import the file using fread 
fread_import <- fread(file_path_1)

# Import the file using read.csv 
base_import <- read.csv(file_path_1)

# Check the class of id column
class(fread_import$id)
class(base_import$id)
# Import using read.csv with defaults
base_r_defaults <- read.csv(file_path_1)
str(base_r_defaults)
# Import using read.csv
# base_r <- read.csv("sample.csv", 
#                    colClasses = c(rep("factor", 4), 
#                                   "character", "integer", 
#                                   rep("numeric", 4)))
# str(base_r)
# Import using fread
# import_fread <- fread("sample.csv", 
#                       colClasses = list(factor = 1:4, numeric = 7:10))
# str(import_fread)
# Import the file and note the warning message
file_path_2 <- "D:/R_data_analyst/Data Manipulation_data.table/sample_2.csv"
file_path_3 <- "D:/R_data_analyst/Data Manipulation_data.table/sample_3.csv"
incorrect <- fread(file_path_2)
incorrect
# Import the file correctly
correct <- fread(file_path_2, fill = TRUE)
correct
# Import the file using na.strings
a <- fread(file_path_3)
a
missing_values <- fread(file_path_3, na.strings = c("##", NA))
missing_values
#######################################################
# list(1:4, 5: 9, 10: 15)
# Write dt to fwrite.txt
# fwrite(dt, "fwrite.txt")
# 
# # Import the file using readLines()
# readLines("fwrite.txt")
# 
# # Import the file using fread()
# fread("fwrite.txt")
###########################################################
# Write batrips_dates to file using "ISO" format
# fwrite(batrips_dates, "iso.txt", dateTimeAs = "ISO" )
# 
# # Import the file back
# iso <- fread("iso.txt")
# iso
###########################################################
# Write batrips_dates to file using "squash" format
# fwrite(batrips_dates, "squash.txt", dateTimeAs = "squash")
# 
# # Import the file back
# squash <- fread("squash.txt")
# squash
###########################################################
# Write batrips_dates to file using "epoch" format
# fwrite(batrips_dates, "epoch.txt", dateTimeAs = "epoch")
# 
# # Import the file back
# epoch <- fread("epoch.txt")
# epoch
############################################################
# Use write.table() to write batrips
# system.time(write.table(batrips, "D:/R_data_analyst/Data Manipulation_data.table/base-r.txt"))
# Use fwrite() to write batrips
system.time(fwrite(batrips, "D:/R_data_analyst/Data Manipulation_data.table/data-table.csv"))