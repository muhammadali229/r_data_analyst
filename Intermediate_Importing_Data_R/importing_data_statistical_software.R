# Load the foreign package
library(foreign)
# Load the haven package
library(haven)
# Import sales.sas7bdat: sales
# sales <- read_sas("sales.sas7bdat")
# Display the structure of sales
# str(sales)
##############################
# Import the data from the URL: sugar
sugar <- read_dta("http://assets.datacamp.com/production/course_1478/datasets/trade.dta") 
# Structure of sugar
str(sugar)
# Convert values in Date column to dates
sugar$Date <- as.Date(as_factor(sugar$Date))
# Structure of sugar again
str(sugar)
plot(sugar$Import, sugar$Weight_I)
##############################
# Import person.sav: traits
# traits <- read_sav("person.sav")
# Summarize traits
# summary(traits)
# Print out a subset
# subset(traits, Extroversion > 40 & Agreeableness > 40)
##############################
# Import SPSS data from the URL: work
work <- read_sav("http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/employee.sav")
# Display summary of work$GENDER
summary(work$GENDER)
# Convert work$GENDER to a factor
work$GENDER <- as_factor(work$GENDER)
# Display summary of work$GENDER again
summary(work$GENDER)
##############################
# Import florida.dta and name the resulting data frame florida
florida <- read.dta("D:/R_data_analyst/Intermediate_Importing_Data_R/florida.dta")
# Check tail() of florida
tail(florida)
##############################
# Specify the file path using file.path(): path
path <- file.path("D:/R_data_analyst/Intermediate_Importing_Data_R", 
                  "edequality.dta")
# Create and print structure of edu_equal_1
edu_equal_1 <- read.dta(path)
str(edu_equal_1)
# Create and print structure of edu_equal_2
edu_equal_2 <- read.dta(path, convert.factors = FALSE)
str(edu_equal_2)
# Create and print structure of edu_equal_3
edu_equal_3 <- read.dta(path, convert.underscore = TRUE)
str(edu_equal_3)
##############################
# how many people) have an age higher than 40 and are literate?
nrow(subset(edu_equal_1, age > 40 & literate == "yes"))
##############################
# How many observations/individuals of Bulgarian ethnicity 
# have an income above 1000?
nrow(subset(edu_equal_1, ethnicity_head = "Bulgarian" & income > 1000))
#head(edu_equal_1)
#################################
# Import international.sav as a data frame: demo
demo <- read.spss("D:/R_data_analyst/Intermediate_Importing_Data_R/international.sav", to.data.frame = TRUE)
# Create boxplot of gdp variable of demo
boxplot(demo$gdp)
#################################
# What is the correlation coefficient for the two numerical 
# variables gdp and f_illit (female illiteracy rate)
cor(demo$gdp, demo$f_illit)
#################################
# Import international.sav as demo_1
demo_1 <- read.spss("D:/R_data_analyst/Intermediate_Importing_Data_R/international.sav", 
                    to.data.frame = TRUE,
                    use.value.labels = TRUE)
# Print out the head of demo_1
head(demo_1)
# Import international.sav as demo_2
demo_2 <- read.spss("D:/R_data_analyst/Intermediate_Importing_Data_R/international.sav", to.data.frame = TRUE, use.value.labels = FALSE)
# Print out the head of demo_2
head(demo_2)