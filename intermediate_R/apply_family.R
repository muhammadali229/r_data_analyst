# The vector pioneers has already been created for you
pioneers <- c("GAUSS:1777", "BAYES:1702", "PASCAL:1623", "PEARSON:1857")
# Split names from birth year
split_math <- strsplit(pioneers, split = ":")
# check type of split_math
class(split_math)
# Convert to lowercase strings: split_low
split_low <- lapply(split_math, tolower)
# Take a look at the structure of split_low
str(split_low)
# Write function select_first()
select_first <- function(x) {
  x[1]
}
# Apply select_first() over split_low: names
names <- lapply(split_low, select_first )
# print names
str(names)
# Write function select_second()
select_second <- function(y) {
  y[2]
}# Apply select_second() over split_low: years
years <- lapply(split_low, select_second)
# print years
str(years)
# split_low has been created for you
split_low
# Transform: use anonymous function inside lapply
names <- lapply(split_low, function(x) {
  x[1]
})
# Transform: use anonymous function inside lapply
years <- lapply(split_low, function(x) {
  x[2]
})
unlist(years)
# Generic select function
select_el <- function(x, index) {
  x[index]
}
# Use lapply() twice on split_low: names and years
names <- lapply(split_low, select_el, index=1)
years <- lapply(split_low, select_el, index=2)
unlist(names)
unlist(years)
# Try to reason about the result before simply executing it in the console!
unlist(lapply(split_low, function(x) {
  if (nchar(x[1]) > 5) {
    return(NULL)
  } else {
    return(x[2])
  }
}))
###########################################################
temp <- list(
  c(3,  7,  9,  6, -1),  c(6,  9, 12, 13,  5),  
  c(4,  8,  3, -1, -3),  c(1,  4,  7,  2, -2), c(5,  7,  9,  4,  2),
  c(-3,  5,  8,  9,  4),  c(3,  6,  9,  4,  1)
)
# temp has already been defined in the workspace
# Use lapply() to find each day's minimum temperature
lapply(temp, min)
# Use sapply() to find each day's minimum temperature
sapply(temp, min)
# Use lapply() to find each day's maximum temperature
lapply(temp, max)
# Use sapply() to find each day's maximum temperature
sapply(temp, max)
# Finish function definition of extremes_avg
extremes_avg <- function(x) {
  ( min(x) + max(x) ) / 2
}
# Apply extremes_avg() over temp using lapply()
lapply(temp, extremes_avg)
# Apply extremes_avg() over temp using sapply()
sapply(temp, extremes_avg)
# Create a function that returns min and max of a vector: extremes
extremes <- function(x) {
  c(min = min(x), max = max(x))
}
# Apply extremes() over temp with lapply()
lapply(temp, extremes)
# Apply extremes() over temp with sapply()
sapply(temp, extremes)
# Definition of below_zero()
below_zero <- function(x) {
  return(x[x < 0])
}
# Apply below_zero over temp using sapply(): freezing_s
freezing_s <- sapply(temp, below_zero)
freezing_s
# Apply below_zero over temp using lapply(): freezing_l
freezing_l <- lapply(temp, below_zero)
freezing_l
# Are freezing_s and freezing_l identical?
identical(freezing_s, freezing_l)
# Definition of print_info()
print_info <- function(x) {
  cat("The average temperature is", mean(x), "\n")
}
# Apply print_info() over temp using sapply()
sapply(temp, print_info)
# Apply print_info() over temp using lapply()
lapply(temp, print_info)
sapply(list(runif (10), runif (10)), 
       function(x) c(min = min(x), mean = mean(x), max = max(x)))
###########################################################
# Definition of basics()
basics <- function(x) {
  c(min = min(x), mean = mean(x), max = max(x))
}
# Apply basics() over temp using vapply()
vapply(temp, basics, numeric(3))
# Definition of the basics() function
basics <- function(x) {
  c(min = min(x), mean = mean(x), median = median(x), max = max(x))
}
# Fix the error:
vapply(temp, basics, numeric(4))
# Convert to vapply() expression
vapply(temp, max, numeric(1))

# Convert to vapply() expression
vapply(temp, function(x, y) { mean(x) > y }, y = 5, logical(1))