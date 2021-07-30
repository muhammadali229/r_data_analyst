# Load the dplyr package
library(dplyr)
# Load the countrycode package
library(countrycode)
# Load the votes dataset
votes <- readRDS("D:/R_data_analyst/Case_Study_Exploratory_Data_Analysis/votes.rds")
# Print the votes dataset
votes
# Filter for votes that are "yes", "abstain", or "no"
votes %>%
  filter(vote <= 3)
###############################################################
# Add another %>% step to add a year column
votes %>%
  filter(vote <= 3) %>%
  mutate(year = 1945 + session)
###############################################################
# Convert country code 100
countrycode(100, "cown", "country.name")
# Add a country column within the mutate: votes_processed
votes_processed <- votes %>%
  filter(vote <= 3 & ccode != 260) %>%
  mutate(year = session + 1945, 
         country = countrycode(ccode, "cown","country.name"))
votes_processed
###############################################################
# Print votes_processed
votes_processed
# Find total and fraction of "yes" votes
votes_processed %>%
  summarize(total = n(), 
            percent_yes = mean(vote == 1))
###############################################################
# Change this code to summarize by year
votes_processed %>%
  group_by(year) %>%
  summarize(total = n(),
            percent_yes = mean(vote == 1))
###############################################################
# Summarize by country: by_country
by_country <- votes_processed %>%
  group_by(country) %>%
  summarize(total = n(),
            percent_yes = mean(vote == 1))
by_country
###############################################################
# Print the by_country dataset
by_country
# Sort in ascending order of percent_yes
by_country %>%
  arrange(percent_yes)
# Now sort in descending order
by_country %>%
  arrange(desc(percent_yes))
###############################################################
# Filter out countries with fewer than 100 votes
by_country %>%
  filter(total >= 100) %>%
  arrange(percent_yes)
###############################################################