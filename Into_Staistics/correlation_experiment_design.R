library(dplyr)
library(ggplot2)
world_happiness <- readRDS("D:/R_data_analyst/Into_Staistics/world_happiness_sugar.rds")
glimpse(world_happiness)
###############################################################
# Create a scatterplot of happiness_score vs. life_exp
ggplot(world_happiness, aes(x = life_exp, y = happiness_score)) +
  geom_point()
# Add a linear trendline to scatterplot
ggplot(world_happiness, aes(life_exp, happiness_score)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)
# It gives you the correlation of 0.8
# Correlation between life_exp and happiness_score
cor(world_happiness$life_exp, world_happiness$happiness_score)
###############################################################
# Scatterplot of gdp_per_cap and life_exp
ggplot(world_happiness, aes(gdp_per_cap, life_exp)) +
  geom_point()
# Correlation between gdp_per_cap and life_exp
cor(world_happiness$gdp_per_cap, world_happiness$life_exp)
# The correlation between GDP per capita and life expectancy is 0.7. 
# Why is correlation not the best way to measure the relationship between 
# the two variables?
# Correlation measures only linear relationships
###############################################################
# Scatterplot of happiness_score vs. gdp_per_cap
ggplot(world_happiness, aes(gdp_per_cap, happiness_score)) +
  geom_point()
# Calculate correlation
cor(world_happiness$gdp_per_cap, world_happiness$happiness_score)
# Create log_gdp_per_cap column
world_happiness <- world_happiness %>%
  mutate(log_gdp_per_cap = log(gdp_per_cap))
# Scatterplot of log_gdp_per_cap vs. happiness_score
ggplot(world_happiness, aes(log_gdp_per_cap, happiness_score)) +
  geom_point()
# Calculate correlation
cor(world_happiness$log_gdp_per_cap, world_happiness$happiness_score)
###############################################################
# Scatterplot of grams_sugar_per_day and happiness_score
ggplot(world_happiness, aes(grams_sugar_per_day, happiness_score)) +
  geom_point()
# Correlation between grams_sugar_per_day and happiness_score
cor(world_happiness$grams_sugar_per_day, world_happiness$happiness_score)
# Increased sugar consumption is associated with a higher happiness score.
###############################################################