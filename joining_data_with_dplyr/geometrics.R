library(ggplot2)
library(carData)
# Plot price vs. carat, colored by clarity
plt_price_vs_carat_by_clarity <- ggplot(diamonds, aes(carat, price, 
                                                      color = clarity))

# Set transparency to 0.5
plt_price_vs_carat_by_clarity + geom_point(alpha = 0.5, shape = 16)

#====================================
# Plot base
plt_mpg_vs_fcyl_by_fam <- ggplot(mtcars, 
                                 aes(factor(cyl), mpg, 
                                     color = factor(am)))

# Default points are shown for comparison
plt_mpg_vs_fcyl_by_fam + geom_point()

# Now jitter and dodge the point positions
plt_mpg_vs_fcyl_by_fam + geom_point(position = position_jitterdodge(dodge.width = 0.3, jitter.width = 0.3))
##########################################
ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
  # Swap for jitter layer with width 0.1
  geom_jitter(alpha = 0.5, width=0.1)
ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
  # Set the position to jitter
  geom_point(alpha = 0.5,
             position='jitter')
ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
  # Use a jitter position function with width 0.1
  geom_point(alpha = 0.5,
             position=position_jitter(width=0.1))
#################################
str(Vocab)
ggplot(Vocab, aes(education, vocabulary)) +
  # Set the shape to 1
  geom_jitter(alpha = 0.2, shape=1)
#################################
datacamp_light_blue <- "#51A8C9"

ggplot(mtcars, aes(mpg, ..density..)) +
  # Set the fill color to datacamp_light_blue
  geom_histogram(binwidth = 1, fill = datacamp_light_blue)
#################################
ggplot(mtcars, aes(mpg, fill = factor(am))) +
  # Change the position to fill
  geom_histogram(binwidth = 1, position = "dodge")
ggplot(mtcars, aes(mpg, fill = factor(am))) +
  # Change the position to fill
  geom_histogram(binwidth = 1, position = "fill")
ggplot(mtcars, aes(mpg, fill = factor(am))) +
  # Change the position to identity, with transparency 0.4
  geom_histogram(binwidth = 1, position = "identity", alpha=0.4)
####################################
ggplot(mtcars, aes(factor(cyl), fill = factor(am))) +
  # Change the position to "dodge"
  geom_bar()
ggplot(mtcars, aes(factor(cyl), fill = factor(am))) +
  # Change the position to "fill"
  geom_bar(position="fill")
ggplot(mtcars, aes(factor(cyl), fill = factor(am))) +
  # Change the position to "dodge"
  geom_bar(position="dodge")
#####################################
ggplot(mtcars, aes(cyl, fill = factor(am))) +
  # Set the transparency to 0.6
  geom_bar(position = position_dodge(width = 0.2),
           alpha=0.6)
######################################
# Plot education, filled by vocabulary
ggplot(Vocab, aes(education, fill = vocabulary)) +
  # Add a bar layer with position "fill"
  geom_bar(position = "fill") +
  # Add a brewer fill scale with default palette
  scale_fill_brewer()
######################################
head(economics)
# Change the y-axis to the proportion of the population that is unemployed
ggplot(economics, aes(date, unemploy / pop )) +
  geom_line()