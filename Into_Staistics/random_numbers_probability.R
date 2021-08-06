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