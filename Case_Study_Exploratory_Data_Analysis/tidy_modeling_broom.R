# Load the dplyr package
library(dplyr)
# Load the tidyr package
library(tidyr)
# Load the ggolot2 package
library(ggplot2)
# Load the purr package
library(purrr)
# Load the countrycode package
library(countrycode)
# Load the broom package
library(broom)
# Load the votes dataset
votes <- readRDS("D:/R_data_analyst/Case_Study_Exploratory_Data_Analysis/votes.rds")
votes_processed <- votes %>%
  filter(vote <= 3 & ccode != 260) %>%
  mutate(year = session + 1945, 
         country = countrycode(ccode, "cown","country.name"))
# Group by year and country: by_year_country
by_year_country <- votes_processed %>%
  group_by(year, country) %>%
  summarize(total = n(),
            percent_yes = mean(vote == 1))
###############################################################
# Percentage of yes votes from the US by year: US_by_year
US_by_year <- by_year_country %>%
  filter(country == "United States")
# Print the US_by_year data
US_by_year
# Perform a linear regression of percent_yes by year: US_fit
US_fit <- lm(percent_yes ~ year, US_by_year)
# Perform summary() on the US_fit object
summary(US_fit)
###############################################################
# Call the tidy() function on the US_fit object
tidy(US_fit)
###############################################################
# Linear regression of percent_yes by year for US
US_by_year <- by_year_country %>%
  filter(country == "United States")
US_fit <- lm(percent_yes ~ year, US_by_year)
# Fit model for the United Kingdom
UK_by_year <- by_year_country %>%
  filter(country == "United Kingdom")
UK_fit <- lm(percent_yes ~ year, UK_by_year)
# Create US_tidied and UK_tidied
US_tidied <- tidy(US_fit)
UK_tidied <- tidy(UK_fit)
# Combine the two tidied models
bind_rows(US_tidied, UK_tidied)
###############################################################
# Nest all columns besides country
by_year_country %>%
  nest(-country)
###############################################################
# All countries are nested besides country
nested <- by_year_country %>%
  nest(-country)
# Print the nested data for Brazil
nested$data[[7]]
###############################################################
# Unnest the data column to return it to its original form
nested %>%
  unnest(-country)
###############################################################
v <- list(1, 2, 3)
map(v, ~ . * 10)
map(v, ~ 1 + .)
###############################################################
# Perform a linear regression on each item in the data column
by_year_country %>%
  nest(-country) %>%
  mutate(model = map(data, ~ lm(percent_yes ~ year, data = .)))
###############################################################
# Add another mutate that applies tidy() to each model
by_year_country %>%
  nest(-country) %>%
  mutate(model = map(data, ~ lm(percent_yes ~ year, data = .))) %>%
  mutate(tidied = map(model, tidy))
###############################################################
# Add one more step that unnests the tidied column
country_coefficients <- by_year_country %>%
  nest(-country) %>%
  mutate(model = map(data, ~ lm(percent_yes ~ year, data = .)),
         tidied = map(model, tidy)) %>%
  unnest(tidied)
# Print the resulting country_coefficients variable
country_coefficients
###############################################################
# Print the country_coefficients dataset
country_coefficients
# Filter for only the slope terms
country_coefficients %>%
  filter(term == "year")
###############################################################
# Filter for only the slope terms
slope_terms <- country_coefficients %>%
  filter(term == "year")
# Add p.adjusted column, then filter
slope_terms %>%
  mutate(p.adjusted = p.adjust(p.value)) %>%
  filter(p.adjusted < 0.05)
###############################################################
# Filter by adjusted p-values
filtered_countries <- country_coefficients %>%
  filter(term == "year") %>%
  mutate(p.adjusted = p.adjust(p.value)) %>%
  filter(p.adjusted < .05)
# Sort for the countries increasing most quickly
filtered_countries %>%
  arrange(desc(estimate))
# Sort for the countries decreasing most quickly
filtered_countries %>%
  arrange(estimate)
###############################################################