# Load the dplyr package
library(dplyr)
# Load the ggolot2 package
library(ggplot2)
# Load the votes dataset
votes <- readRDS("D:/R_data_analyst/Case_Study_Exploratory_Data_Analysis/votes.rds")
votes_processed <- votes %>%
  filter(vote <= 3 & ccode != 260) %>%
  mutate(year = session + 1945, 
         country = countrycode(ccode, "cown","country.name"))
###############################################################
# Define by_year
by_year <- votes_processed %>%
  group_by(year) %>%
  summarize(total = n(),
            percent_yes = mean(vote == 1))
# Create line plot
ggplot(by_year, aes(x = year, y = percent_yes)) +
  geom_line()
###############################################################
# Change to scatter plot and add smoothing curve
ggplot(by_year, aes(year, percent_yes)) +
  geom_point() +
  geom_smooth()
###############################################################
# Group by year and country: by_year_country
by_year_country <- votes_processed %>%
  group_by(year, country) %>%
  summarize(total = n(),
            percent_yes = mean(vote == 1))
###############################################################
# Print by_year_country
by_year_country
# Create a filtered version: UK_by_year
UK_by_year <- by_year_country %>%
  filter(country == "United Kingdom")
# Line plot of percent_yes over time for UK only
ggplot(UK_by_year, aes(x = year, y = percent_yes)) +
  geom_line()
###############################################################
# Vector of four countries to examine
countries <- c("United States", "United Kingdom",
               "France", "India")
# Filter by_year_country: filtered_4_countries
filtered_4_countries <- by_year_country %>%
  filter(country %in% countries)
# Line plot of % yes in four countries
ggplot(filtered_4_countries, aes(x = year, y = percent_yes, color = country)) +
  geom_line()
###############################################################
# Vector of six countries to examine
countries <- c("United States", "United Kingdom",
               "France", "Japan", "Brazil", "India")
# Filtered by_year_country: filtered_6_countries
filtered_6_countries <- by_year_country %>%
  filter(country %in% countries)
# Line plot of % yes over time faceted by country
ggplot(filtered_6_countries, aes(x = year, y = percent_yes)) +
  geom_line() +
  facet_wrap(~ country)
# Line plot of % yes over time faceted by country
ggplot(filtered_6_countries, aes(year, percent_yes)) +
  geom_line() +
  facet_wrap(~ country, scales = "free_y")
###############################################################
by_country$country
# Add three more countries to this list
countries <- c("United States", "United Kingdom",
               "France", "Japan", "Brazil", "India",
               "Pakistan", "Norway", "Germany")
# Filtered by_year_country: filtered_countries
filtered_countries <- by_year_country %>%
  filter(country %in% countries)
# Line plot of % yes over time faceted by country
ggplot(filtered_countries, aes(year, percent_yes)) +
  geom_line() +
  facet_wrap(~ country, scales = "free_y")
###############################################################