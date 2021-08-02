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
descriptions <- readRDS(("D:/R_data_analyst/Case_Study_Exploratory_Data_Analysis/descriptions.rds"))
votes_processed <- votes %>%
  filter(vote <= 3 & ccode != 260) %>%
  mutate(year = session + 1945, 
         country = countrycode(ccode, "cown","country.name"))
###############################################################
# Print the votes_processed dataset
votes_processed
# Print the descriptions dataset
descriptions
# Join them together based on the "rcid" and "session" columns
votes_joined <- votes_processed %>%
  inner_join(descriptions, 
             by = c("rcid", "session"))
###############################################################
# Filter for votes related to colonialism
votes_joined %>%
  filter(co == 1)
###############################################################
# Filter, then summarize by year: US_co_by_year
US_co_by_year <- votes_joined %>%
  filter(country == "United States" & co == 1) %>%
  group_by(year) %>%
  summarize(percent_yes = mean(vote == 1))
# Graph the % of "yes" votes over time
ggplot(US_co_by_year, 
       aes(x = year, y = percent_yes)) +
  geom_line()
###############################################################
# Gather the six me/nu/di/hr/co/ec columns
votes_joined %>%
  gather(topic, has_topic, me:ec)
# Perform gather again, then filter
votes_gathered <- votes_joined %>%
  gather(topic, has_topic, me:ec) %>%
  filter(has_topic == 1)
###############################################################
# Replace the two-letter codes in topic: votes_tidied
votes_tidied <- votes_gathered %>%
  mutate(topic = recode(topic,
                        me = "Palestinian conflict",
                        nu = "Nuclear weapons and nuclear material",
                        di = "Arms control and disarmament",
                        hr = "Human rights",
                        co = "Colonialism",
                        ec = "Economic development"))
###############################################################
# Print votes_tidied
votes_tidied
# Summarize the percentage "yes" per country-year-topic
by_country_year_topic <- votes_tidied %>%
  group_by(country, year, topic) %>%
  summarize(total = n(), percent_yes = mean(vote == 1)) %>% ungroup() 
# Print by_country_year_topic
by_country_year_topic
###############################################################
# Filter by_country_year_topic for just the US
US_by_country_year_topic <- by_country_year_topic %>%
  filter(country == "United States")
# Plot % yes over time for the US, faceting by topic
ggplot(US_by_country_year_topic, 
       aes(x = year, y = percent_yes)) + 
  geom_line() +
  facet_wrap(~ topic)
###############################################################
# Print by_country_year_topic
by_country_year_topic
# Fit model on the by_country_year_topic dataset
country_topic_coefficients <- by_country_year_topic %>%
  nest(-country, -topic) %>%
  mutate(model = map(data, ~ lm(percent_yes ~ year, data = .)),
         tidied = map(model, tidy)) %>%
  unnest(tidied)
# Print country_topic_coefficients
country_topic_coefficients
###############################################################
# Create country_topic_filtered
country_topic_filtered <- country_topic_coefficients %>%
  filter(term == "year") %>%
  mutate(p.adjusted = p.adjust(p.value)) %>%
  filter(p.adjusted < .05)
country_topic_filtered %>%
  arrange(estimate)
###############################################################
# Create vanuatu_by_country_year_topic
vanuatu_by_country_year_topic <- by_country_year_topic %>% filter(country == "Vanuatu")
# Plot of percentage "yes" over time, faceted by topic
ggplot(vanuatu_by_country_year_topic, 
       aes(x = year, y = percent_yes)) +
  geom_line() +
  facet_wrap(~topic)
###############################################################