library(dplyr)
library(ggplot2)
amir_deals <- readRDS("D:/R_data_analyst/Into_Staistics/seller_1.rds")
glimpse(amir_deals)
###############################################################
# Count the deals for each product
amir_deals %>%
  count(product)
# Calculate probability of picking a deal with each product
amir_deals %>%
  count(product) %>%
  mutate(prob = n / sum(n))
###############################################################
# Set random seed to 31
set.seed(31)
# Sample 5 deals without replacement
amir_deals %>%
  sample_n(5)
# Sample 5 deals with replacement
amir_deals %>%
  sample_n(5, replace = TRUE)
###############################################################
restaurant_groups <- data.frame(
  group_id = c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J"),
  group_size = c(2, 4, 6, 2, 2, 2, 3, 2, 4, 2)
)
# Create a histogram of group_size
ggplot(restaurant_groups, aes(group_size)) +
  geom_histogram(bins = 5)
# Create probability distribution
size_distribution <- restaurant_groups %>%
  # Count number of each group size
  count(group_size) %>%
  # Calculate probability
  mutate(probability = n / sum(n))
size_distribution
# Calculate expected group size
expected_val <- sum(size_distribution$probability *
                      size_distribution$group_size)
expected_val
# Create probability distribution
size_distribution <- restaurant_groups %>%
  count(group_size) %>%
  mutate(probability = n / sum(n))
# Calculate probability of picking group of 4 or more
size_distribution %>%
  # Filter for groups of 4 or larger
  filter(group_size >= 4) %>%
  # Calculate prob_4_or_more by taking sum of probabilities
  summarize(prob_4_or_more = sum(probability))
###############################################################









###############################################################