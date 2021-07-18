library(ggplot2)
str(mtcars)

ggplot(mtcars, aes(mpg, factor(cyl))) + geom_point()

ggplot(mtcars, aes(wt, mpg, color = factor(cyl))) +
  # Set the shape and size of the points
  geom_point(shape=1, size=4)

# Map color to fame
ggplot(mtcars, aes(wt, mpg, fill = factor(cyl), color=factor(am))) +
  geom_point(shape = 21, size = 4, alpha = 0.6)

# Base layer
plt_mpg_vs_wt <- ggplot(mtcars, aes(wt, mpg))

# Use text layer and map fcyl to label
plt_mpg_vs_wt +
  geom_text(aes(label = factor(cyl)))

# A hexadecimal color
my_blue <- "#4ABEFF"

# Change the color mapping to a fill mapping
ggplot(mtcars, aes(wt, mpg, fill = factor(cyl))) +
  # Set point size and shape
  geom_point(color=my_blue, size=10, shape=1)

ggplot(mtcars, aes(wt, mpg, color = fcyl)) +
  # Add text layer with label rownames(mtcars) and color red
  geom_text(label=rownames(mtcars), color='red')

ggplot(mtcars, aes(wt, mpg, color = fcyl)) +
  # Add points layer with shape 24 and color yellow
  geom_point(shape=24, color='yellow')

# 5 aesthetics: add a mapping of size to hp / wt
ggplot(mtcars, aes(mpg, qsec, color = factor(cyl), shape = factor(am),
                   size=hp / wt)) +
  geom_point()

palette <- c(automatic = "#377EB8", manual = "#E41A1C")

# Set the position
ggplot(mtcars, aes(factor(cyl), fill = factor(am))) +
  geom_bar(position = "dodge") +
  labs(x = "Number of Cylinders", y = "Count")
scale_fill_manual("Transmission", values = palette)

# ggplot(mtcars, aes(mpg, 0)) +
#   geom_jitter() +
#   # Set the y-axis limits
#   ylim(-2, 2)

