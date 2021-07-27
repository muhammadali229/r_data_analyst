library(readr)
library(dplyr)
library(ggplot2)
# Load comics dataset
cars <- read_csv("D:/R_data_analyst/exploratoryDataAnalysis/cars04.csv")
# Learn data structure
str(cars)
# Create faceted histogram
ggplot(cars, aes(x = city_mpg)) +
  geom_histogram() +
  facet_wrap(~ suv)
##################################################
uniqe_no_cylinders <- unique(cars$ncyl)
print(uniqe_no_cylinders)
# Filter cars with 4, 6, 8 cylinders
common_cyl <- filter(cars, ncyl %in% c(4, 6, 8))
# Create box plots of city mpg by ncyl
ggplot(common_cyl, aes(x = as.factor(ncyl), y = city_mpg)) +
  geom_boxplot()
# Create overlaid density plots for same data
ggplot(common_cyl, aes(x = city_mpg, fill = as.factor(ncyl))) +
  geom_density(alpha = .3)
##################################################
# Create hist of horsepwr
cars %>%
  ggplot(aes(horsepwr)) +
  geom_histogram() +
  ggtitle("Across all cars")
# Create hist of horsepwr for affordable cars
cars %>% 
  filter(msrp < 25000) %>%
  ggplot(aes(horsepwr)) +
  geom_histogram() +
  xlim(c(90, 550)) +
  ggtitle("Only cars less than 25000")
##################################################
# Create hist of horsepwr with binwidth of 3
cars %>%
  ggplot(aes(horsepwr)) +
  geom_histogram(binwidth = 3) +
  ggtitle("Distribution of horsepower (Binwidth = 3)")
# Create hist of horsepwr with binwidth of 30
cars %>%
  ggplot(aes(horsepwr)) +
  geom_histogram(binwidth = 30) +
  ggtitle("Distribution of horsepower (Binwidth = 30)")
# Create hist of horsepwr with binwidth of 60
cars %>%
  ggplot(aes(horsepwr)) +
  geom_histogram(binwidth = 60) +
  ggtitle("Distribution of horsepower (Binwidth = 60)")
##################################################
# Construct box plot of msrp
cars %>%
  ggplot(aes(x = 1, y = msrp)) +
  geom_boxplot()
# Exclude outliers from data
cars_no_out <- cars %>%
  filter(msrp < 100000)
# Construct box plot of msrp using the reduced dataset
cars_no_out %>%
  ggplot(aes(x = 1, y = msrp)) +
  geom_boxplot()
##################################################
# Create plot of city_mpg -> density
cars %>%
  ggplot(aes(city_mpg)) +
  geom_density()
# Create plot of city_mpg -> boxplot
cars %>%
  ggplot(aes(x = 1, y = city_mpg)) +
  geom_boxplot()
# Create plot of city_mpg -> density
cars %>%
  ggplot(aes(width)) +
  geom_density()
# Create plot of city_mpg -> boxplot
cars %>%
  ggplot(aes(x = 1, y = width)) +
  geom_boxplot()
##################################################
# Facet hists using hwy mileage and ncyl
common_cyl %>%
  ggplot(aes(x = hwy_mpg)) +
  geom_histogram() +
  facet_grid(ncyl ~ suv, labeller = label_both) +
  ggtitle("Rows: ncyl, Columns: suv")
##################################################