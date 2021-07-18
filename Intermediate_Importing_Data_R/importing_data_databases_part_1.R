# Load the DBI package
library(DBI)
# Edit dbConnect() call
con <- dbConnect(RMySQL::MySQL(), 
                 dbname = "tweater", 
                 host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                 port = 3306,
                 user = "student",
                 password = "datacamp")
# Build a vector of table names: tables
tables <- c(dbListTables(con))
# Display structure of tables
str(tables)
# Import the users table from tweater: users
users <- dbReadTable(con, "users")
# Print users
users
# Get table names
table_names <- dbListTables(con)
# Import all tables
tables <- lapply(c(table_names), dbReadTable, conn = con)
# Print out tables
tables
# Closed the connection
dbDisconnect(con)