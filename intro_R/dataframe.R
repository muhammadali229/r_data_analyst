# Print out built-in R data frame
mtcars
#################################
# Call head() on mtcars
head(mtcars)
# for only 2 items from the head
head(mtcars, 2)
# Call tail() on mtcars
tail(mtcars)
# for only 3 items from the last
tail(mtcars, 3)
#################################
# Investigate the structure of mtcars
str(mtcars)
#################################
# Definition of vectors
name <- c("Mercury", "Venus", "Earth", 
          "Mars", "Jupiter", "Saturn", 
          "Uranus", "Neptune")
type <- c("Terrestrial planet", 
          "Terrestrial planet", 
          "Terrestrial planet", 
          "Terrestrial planet", "Gas giant", 
          "Gas giant", "Gas giant", "Gas giant")
diameter <- c(0.382, 0.949, 1, 0.532, 
              11.209, 9.449, 4.007, 3.883)
rotation <- c(58.64, -243.02, 1, 1.03, 
              0.41, 0.43, -0.72, 0.67)
rings <- c(FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE)

# Create a data frame from the vectors
planets_df <- data.frame(name, type, 
                         diameter, rotation, rings)
# Check the structure of planets_df
str(planets_df)
#################################
planets_df
# Print out diameter of Mercury (row 1, column 3)
planets_df[1,3]
# Print out data for Mars (entire fourth row)
planets_df[4,1:5]
# you can also do like this
planets_df[4,]
#################################
# Select first 5 values of diameter column
planets_df[1:5,3]
# you can also use variable name
planets_df[1:5, 'diameter']
#################################
# Select the rings variable from planets_df
planets_df[,'rings']
planets_df[, 5]
rings_vector <- planets_df$rings
# Print out rings_vector
rings_vector
#################################
# Adapt the code to select all columns for planets with rings
planets_df[rings_vector, ]
# same result using subset
subset(planets_df, subset=rings)
# if we want to know the planets with no rings
subset(planets_df, subset=!rings)
# Select planets with diameter < 1
subset(planets_df, subset=diameter < 1)
##################################
# Play around with the order function in the console
a <- c('b','a','c')
a 
# ascending
order(a)
a[order(a)]
# descending
order(a, decreasing = TRUE)
a[order(a, decreasing = TRUE)]
###################################
# Use order() to create positions
positions <-  order(planets_df$diameter, decreasing = TRUE)
positions
# Use positions to sort planets_df
planets_df[positions, ]