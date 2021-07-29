# Load packages
library(ggplot2)
library(dplyr)
library(openintro)
str(email)
# Compute summary statistics
email %>%
  group_by(spam) %>%
  summarize(median(num_char), IQR(num_char))
# Create plot
email %>%
  mutate(log_num_char = log(num_char)) %>%
  ggplot(aes(x = spam, y = log_num_char)) +
  geom_boxplot()
##################################################
# Compute center and spread for exclaim_mess by spam
email %>%
  group_by(spam) %>%
  summarize(median(exclaim_mess), IQR(exclaim_mess))
# Create plot for spam and exclaim_mess
ggplot(email, aes(log(exclaim_mess))) +
  geom_histogram() +
  facet_wrap(~ spam)
##################################################
table(email$image)
# Create plot of proportion of spam by image
email %>%
  mutate(has_image = image > 0) %>%
  ggplot(aes(x = has_image, fill = spam)) +
  geom_bar(position = "fill")
##################################################
# Test if images count as attachments
sum(email$image > email$attach)
##################################################
# Within non-spam emails, is the typical length of emails shorter 
# for those that were sent to multiple people?
email %>%
  filter(spam == "not-spam") %>%
  group_by(to_multiple) %>%
  summarize(median(num_char))
# ------------------------------------------------
# Question 1
email %>%
  filter(dollar > 0) %>%
  group_by(spam) %>%
  summarize(median(num_char))
# ------------------------------------------------
# Question 2
email %>%
  filter(dollar > 10) %>%
  ggplot(aes(x = spam)) +
  geom_bar()
##################################################
# Reorder levels
email$number_reordered <- factor(email$number, 
                                 levels = c("none", "small", "big"))
# Construct plot of number_reordered
ggplot(email, aes(number_reordered)) +
  geom_bar()
facet_wrap(~ spam)
##################################################