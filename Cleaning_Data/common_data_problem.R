library(dplyr)
library(assertive)
library(stringr)
library(lubridate)
library(ggplot2)
# Load bike_share_rides
bike_share_rides <- readRDS("D:/R_data_analyst/Cleaning_Data/bike_share_rides_ch1_1.rds")
# Glimpse at bike_share_rides
glimpse(bike_share_rides)
# Summary of user_birth_year
summary(bike_share_rides$user_birth_year)
# Convert user_birth_year to factor: user_birth_year_fct
bike_share_rides <- bike_share_rides %>%
  mutate(user_birth_year_fct = factor(user_birth_year))
# Assert user_birth_year_fct is a factor
assert_is_factor(bike_share_rides$user_birth_year_fct)
# Glimpse at bike_share_rides
glimpse(bike_share_rides)
# Summary of user_birth_year_fct
summary(bike_share_rides$user_birth_year_fct)
#########################################################
bike_share_rides <- bike_share_rides %>%
  # Remove 'minutes' from duration: duration_trimmed
  mutate(duration_trimmed = str_remove(duration, "minutes"),
         # Convert duration_trimmed to numeric: duration_min
         duration_min = as.numeric(duration_trimmed))
# Glimpse at bike_share_rides
glimpse(bike_share_rides)
# Assert duration_min is numeric
assert_is_numeric(bike_share_rides$duration_min)
# Calculate mean duration
mean(bike_share_rides$duration_min)
#########################################################
# Create breaks
breaks <- c(min(bike_share_rides$duration_min), 0, 1440, max(bike_share_rides$duration_min))
# Create a histogram of duration_min
ggplot(bike_share_rides, aes(duration_min)) +
  geom_histogram(breaks = breaks)
# duration_min_const: replace vals of duration_min > 1440 with 1440
bike_share_rides <- bike_share_rides %>%
  mutate(duration_min_const = replace(duration_min, duration_min > 1440, 1440))
# Make sure all values of duration_min_const are between 0 and 1440
assert_all_are_in_closed_range(bike_share_rides$duration_min_const, lower = 0, upper = 1440)
#########################################################
# Convert date to Date type
bike_share_rides <- bike_share_rides %>%
  mutate(date = as.Date(date))
# Make sure all dates are in the past
assert_all_are_in_past(bike_share_rides$date)
# Filter for rides that occurred before or on today's date
bike_share_rides_past <- bike_share_rides %>%
  filter(date <= today())
# Make sure all dates from bike_share_rides_past are in the past
assert_all_are_in_past(bike_share_rides_past$date)
#########################################################
# Count the number of full duplicates
sum(duplicated(bike_share_rides))
# filter(bike_share_rides, duplicated(bike_share_rides))
# Remove duplicates
bike_share_rides_unique <- distinct(bike_share_rides)
# Count the full duplicates in bike_share_rides_unique
sum(duplicated(bike_share_rides_unique))
#########################################################
# Find duplicated ride_ids
bike_share_rides %>% 
  # Count the number of occurrences of each ride_id
  count(ride_id) %>% 
  # Filter for rows with a count > 1
  filter(n > 1)
# Remove full and partial duplicates
bike_share_rides_unique <- bike_share_rides %>%
  # Only based on ride_id instead of all cols
  distinct(ride_id, .keep_all = TRUE)
sum(duplicated(bike_share_rides_unique))
# Find duplicated ride_ids in bike_share_rides_unique
bike_share_rides_unique %>%
  # Count the number of occurrences of each ride_id
  count(ride_id) %>%
  # Filter for rows with a count > 1
  filter(n > 1)
#########################################################
# head(bike_share_rides, 10)
bike_share_rides %>%
  # Group by ride_id and date
  group_by(ride_id, date) %>%
  # Add duration_min_avg column
  mutate(duration_min_avg = mean(duration_min) ) %>%
  # Remove duplicates based on ride_id and date, keep all cols
  distinct(ride_id, date, .keep_all = TRUE) %>%
  # Remove duration_min column
  select(-duration_min)
#########################################################