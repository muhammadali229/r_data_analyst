library(dplyr)
library(ggplot2)
amir_deals <- readRDS("D:/R_data_analyst/Into_Staistics/seller_1.rds")
glimpse(amir_deals)
head(amir_deals, 10)
###############################################################
# Histogram of amount with 10 bins
ggplot(amir_deals, aes(amount)) +
  geom_histogram(bins = 10) 
# Amount column shows normal distribution
###############################################################
# Probability of deal < 7500
pnorm(7500, mean = 5000, sd = 2000)
# Probability of deal > 1000
pnorm(1000, mean = 5000, sd = 2000, lower.tail = FALSE)
# Probability of deal between 3000 and 7000
pnorm(7000, mean = 5000, sd = 2000) - pnorm(3000, mean = 5000, sd = 2000) 
# Calculate amount that 75% of deals will be more than
qnorm(0.75, mean = 5000, sd = 2000, lower.tail = FALSE)
###############################################################
new_sales <- data.frame(
  sale_num = seq(1, 36)
)
# Calculate new average amount
new_mean <- 5000 + (5000 * 0.2)
new_mean
# Calculate new standard deviation
new_sd <- 2000 + (2000 * 0.3)
new_sd
# Simulate 36 sales
new_sales <- new_sales %>% 
  mutate(amount = rnorm(36, mean = new_mean, sd = new_sd))
# Create histogram with 10 bins
ggplot(new_sales, aes(amount)) +
  geom_histogram(bins = 10)
###############################################################
# Based only on the metric of percent of sales over $1000, 
# does Amir perform better in the current market or the predicted market?
pnorm(1000, mean = 5000, sd = 2000, lower.tail = FALSE)
pnorm(1000, mean = 6000, sd = 2600, lower.tail = FALSE)
###############################################################
# Create a histogram of num_users
ggplot(amir_deals, aes(num_users)) +
  geom_histogram(bins = 10)
# Set seed to 104
set.seed(104)
# Sample 20 num_users with replacement from amir_deals
sample(amir_deals$num_users, 20, replace = TRUE) %>%
  # Take mean
  mean()
# Repeat the above 100 times
sample_means <- replicate(100, 
                          sample(amir_deals$num_users, size = 20, replace = TRUE) %>% mean())
# Create data frame for plotting
samples <- data.frame(mean = sample_means)
# Histogram of sample means
ggplot(samples, aes(mean)) +
  geom_histogram(bins = 10)  
###############################################################
# Set seed to 321
# set.seed(321)
# # Take 30 samples of 20 values of num_users, take mean of each sample
# sample_means <- replicate(30, sample(all_deals$num_users, 20) %>% mean())
# # Calculate mean of sample_means
# mean(sample_means)
# # Calculate mean of num_users in amir_deals
# mean(amir_deals$num_users)
###############################################################
# Probability of 5 responses
dpois(5, lambda = 4)
# Probability of 5 responses from coworker
dpois(5, lambda = 5.5)
# Probability of 2 or fewer responses
ppois(2, lambda = 4)
# Probability of > 10 responses
ppois(10, lambda = 4, lower.tail = FALSE)
###############################################################
# Probability response takes < 1 hour
pexp(1, rate = 0.4)
# Probability response takes > 4 hours
pexp(4, rate = 0.4, lower.tail = FALSE)
# Probability response takes 3-4 hours
pexp(4, rate = 0.4) - pexp(3, rate = 0.4)
###############################################################