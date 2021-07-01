# Vector with numerics from 1 up to 10
my_vector <- 1:10 
# my_vector
# Matrix with numerics from 1 up to 9
my_matrix <- matrix(1:9, ncol = 3)
# my_matrix
# First 10 elements of the built-in data frame mtcars
my_df <- mtcars[1:10,]
# my_df
# Construct list with these different elements:
my_list <- list(my_vector, my_matrix, my_df)
# print my_list
my_list
########################################################
names(my_list) = c('vec', 'mat', 'df')
# Print out my_list
my_list
########################################################
# selecting mat from my_list
my_list[[2]]
my_list[['df']]
my_list$vec
my_list[['df']][1:2,]
########################################################
# Use the table from the exercise to define the comments and scores vectors
scores <- c(4.6, 5, 4.8, 5, 4.2)
comments <- c("I would watch it again", "Amazing!", "I liked it", "One of the best movies", "Fascinating plot")

# Save the average of the scores vector as avg_review  
avg_review = mean(scores)
avg_review
# Combine scores and comments into the reviews_df data frame
reviews_df = data.frame(scores, comments)
reviews_df

# Create and print out a list, called departed_list
movie_title <- 'The Departed'
movie_actors <- c("Leonardo DiCaprio", "Matt Damon", "Jack Nicholson",   
                  "Mark Wahlberg", "Vera Farmiga", "Martin Sheen")
departed_list = list(movie_title, 
                     movie_actors, reviews_df, avg_review)

departed_list