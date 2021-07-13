# Load data.table
library(data.table)
students <- fread("D:/R_data_analyst/Joining_data_data.table/school/school_db_students.tsv")
guardians <- fread("D:/R_data_analyst/Joining_data_data.table/school/school_db_guardians.tsv")
subjects <- fread("D:/R_data_analyst/Joining_data_data.table/school/school_db_subjects.tsv")
locations <- fread("D:/R_data_analyst/Joining_data_data.table/school/school_db_locations.tsv")
teachers <- fread("D:/R_data_analyst/Joining_data_data.table/school/school_db_teachers.tsv")
area <- fread("D:/R_data_analyst/Joining_data_data.table/aus_pop/australia_area.csv")
capitals <- fread("D:/R_data_analyst/Joining_data_data.table/aus_pop/australia_capitals.csv")
population <- fread("D:/R_data_analyst/Joining_data_data.table/aus_pop/australia_cities_top20.csv")
heart <- fread("D:/R_data_analyst/Joining_data_data.table/heart/heart.csv")
cardio <- fread("D:/R_data_analyst/Joining_data_data.table/heart/cardio.csv")
framingham <- fread("D:/R_data_analyst/Joining_data_data.table/heart/framingham.csv")
# structure of students and guardians
str(students)
str(guardians)
# Full join
merge(x = students, y = guardians, by = "name", all = TRUE)
# Left join
merge(x = students, y = guardians, by = "name", all.x = TRUE)
# Inner join
students[guardians, on = .(name), nomatch = 0]
# What are the correct join key columns?
students[guardians, on = .(guardian = name), nomatch = 0]
str(subjects)
str(locations)
# Right join
subjects[locations, on = .(semester, class)]
# Structure 
str(subjects)
str(locations)
# Does semester have the same class? 
same_class <- class(subjects$semester) == class(locations$semester)
# Fix the column class
locations[, semester := as.integer(semester)]
# Right join
subjects[locations, on = .(semester, class)]
str(teachers)
str(locations)
# Identify and set the keys
join_key <- c("subject" = "class")
# Right join
teachers[locations, on = join_key]
######################################################
str(capitals)
str(population)
str(area)
# Inner join
capital_pop <- merge(capitals, population, by = "city")
# Left join
merge(capital_pop, area, by = "state", all.x = TRUE)
# Inner join from step 1
capital_pop <- merge(capitals, population, by = "city")
# Left join with suffixes
merge(capital_pop, area, by = "state", all.x = TRUE, suffix = c(".pop", ".area"))
# Convert netflix to a data.table
netflix_dt <- as.data.table(netflix, keep.rownames = "series")
netflix_dt
imdb
# Right join
imdb[netflix_dt, on = .(title)]
##########################################################
# Try an inner join
merge(x = heart, y = cardio, by = "gene", allow.cartesian = TRUE)
# Filter missing values
heart_2 <- heart[!is.na(gene)]
cardio_2 <- cardio[!is.na(gene)]
# Inner join the filtered data.tables
merge(x = heart_2, y = cardio_2, by = "gene", allow.cartesian = TRUE)
# Keep only the last probe for each gene
heart_3 <- unique(heart_2, by = "gene", fromLast = TRUE)
cardio_3 <- unique(cardio_2, by = "gene", fromLast = TRUE)
# Inner join
reproducible <- merge(heart_3, cardio_3, by = "gene", suffix = c(".heart", ".cardio"))
reproducible
# Right join taking the first match
heart_2[framingham, on = .(gene), mult = "first"]
# Anti-join
reproducible[!framingham, on = .(gene)]