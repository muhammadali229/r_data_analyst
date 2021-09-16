library(tidyverse)
library(lubridate)
# Understanding variables
first_variable <- "Coding in R"
second_variable <- 2.5

# a vector contain elements of same data type
vect_1 <- c(13, 48.5, 19.24, 101.6, 2)
vect_1
vect_2 <- c(1L, 5L, 15L)
vect_2

vect_3 <- c("Sara" , "Lisa" , "Anna")
vect_4 <- c(TRUE, FALSE, TRUE)

# check the type of these vectors
typeof(vect_1)
typeof(vect_2)
typeof(vect_3)
typeof(vect_4)

# you can also check these in specific
is.double(vect_1)
is.integer(vect_2)
is.character(vect_3)
is.logical(vect_4)

# you can also names your vector elements
names(vect_1) <- c("a", "b", "c", "d", "e")
vect_1

# creating a list 
a <- list("a", 1L, 1.5, TRUE)
b <- list(list(list(1 , 3, 5)))

# it will display the structure of list
str(a)
str(b)

# you can name your list elements
list('Chicago' = 1, 'New York' = 2, 'Los Angeles' = 3)

# get the current date
today()
# get the current date and time
now()
# convert string into date
ymd("2021-01-20")
mdy("January 20th, 2021")
dmy("20-Jan-2021")
# convert unquoted into date
ymd(20210120)
# convert it into date and time also
ymd_hms("2021-01-20 20:11:59")
mdy_hm("01/20/2021 08:01")
# convert datetime to date
as_date(now())

# creating a dataframe each row is observation and a column is of same data type
data.frame(x = c(1, 2, 3) , y = c(1.5, 5.5, 7.5))

# files and dirs
# dir.create ("destination_folder") 
# return TRUE if create or FALSE if not
# file.create ("new_csv_file.csv") 
# Copy file
# file.copy ("new_text_file.txt" , "destination_folder")
# deleting files
# unlink ("some_.file.csv")

# creating matrix
matrix(c(3:8), nrow = 2)
matrix(c(3:8), ncol = 2)

###############################################
# our first calculation
quarter_1_sales <- 3454.98
quarter_2_sales <- 5642.93
mid_year_sales <- quarter_1_sales + quarter_2_sales
year_end_sales <- 2 * mid_year_sales

TRUE & TRUE
TRUE & FALSE
FALSE & TRUE
FALSE & FALSE

x <- 10
x > 3 & x < 12
x <- 20
x > 3 & x < 12

TRUE | TRUE
TRUE | FALSE
FALSE | TRUE
FALSE | FALSE

y <- 7
y < 8 | y > 16
y <- 12
y < 8 | y > 16

!TRUE
FALSE
!FALSE

x <- 2
!x

# conditions
x <- 4
if (x > 0) {
  print("x is a positive number")
}
x <- -7
if (x > 0) {
  print ("x is a positive number")
} else {
  print ("x is either a negative number or zero")
}

x <- -1
if (x < 0) {
  print("x is a negative number")
} else if (x == 0) {
  print("x is zero")
} else {
  print("x is a positive number")
}

# browseVignettes("ggplot2")