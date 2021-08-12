# Load readr
library(readr)
# Load dylyr
library(dplyr)
# Load tidyr
library(tidyr)
# Load ggplot2
library(ggplot2)
# Load forcats
library(forcats)
# Load stringr
library(stringr)
# Load multiple_choice_responses_old dataset
#multiple_choice_responses_old <- read_csv("D:/R_data_analyst/Categorical_data_tidyverse/smc_with_js.csv")
multiple_choice_responses <- read_csv("D:/R_data_analyst/Categorical_data_tidyverse/multipleChoiceResponses.csv")
multiple_choice_responses <- multiple_choice_responses %>%
  mutate_if(is.character, as.factor)
###############################################################
learning_platform_usefulness <- multiple_choice_responses %>%
  # select columns with LearningPlatformUsefulness in title
  select(contains("LearningPlatformUsefulness")) %>%
  # change data from wide to long
  gather(learning_platform, usefulness) %>%
  # remove rows where usefulness is NA
  filter(!is.na(usefulness)) %>%
  # remove "LearningPlatformUsefulness" from each string in learning_platform 
  mutate(learning_platform = str_remove(learning_platform, 'LearningPlatformUsefulness'))
# print learning_platform_usefulness
learning_platform_usefulness
###############################################################
perc_useful_platform <- learning_platform_usefulness %>%
  # change dataset to one row per learning_platform usefulness pair with number of entries for each
  count(learning_platform, usefulness) %>%
  # use add_count to create column with total number of answers for that learning_platform
  add_count(learning_platform, wt = n, name='nn') %>%
  # create a new column, perc, that is the percentage of people giving that response for that learning_platform
  mutate(perc = n / nn)
perc_useful_platform
# create a line graph for each question with usefulness on x-axis and percentage of responses on y
ggplot(perc_useful_platform, aes(x = usefulness, y = perc, group = learning_platform)) + 
  geom_line() + 
  facet_wrap(~ learning_platform)
###############################################################
usefulness_by_platform <- learning_platform_usefulness %>%
  # If usefulness is "Not Useful", make 0, else 1 
  mutate(usefulness = if_else(usefulness == "Not Useful", 0, 1)) %>%
  # Group by learning platform 
  group_by(learning_platform) %>%
  # Summarize the mean usefulness for each platform
  summarize(avg_usefulness = mean(usefulness))
# Make a scatter plot of average usefulness by learning platform 
ggplot(usefulness_by_platform, aes(x = learning_platform, y = avg_usefulness)) + 
  geom_point()
###############################################################
ggplot(usefulness_by_platform, aes(x = learning_platform, y = avg_usefulness)) + 
  geom_point() + 
  # rotate x-axis text by 90 degrees
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  # rename y and x axis labels
  labs(x = "Learning Platform", y  = "Percent finding at least somewhat useful") + 
  # change y axis scale to percentage
  scale_y_continuous(labels = scales::percent)
###############################################################
usefulness_by_platform %>%
  # reorder learning_platform by avg_usefulness
  mutate(learning_platform = fct_reorder(learning_platform, avg_usefulness)) %>%
  # reverse the order of learning_platform
  mutate(learning_platform = fct_rev(learning_platform)) %>%
  ggplot(aes(x = learning_platform, y = avg_usefulness)) + 
  geom_point() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  labs(x = "Learning Platform", y = "Percent finding at least somewhat useful") + 
  scale_y_continuous(labels = scales::percent)
###############################################################
# Check the min age
min(multiple_choice_responses$Age, na.rm = TRUE)
# Check the max age
max(multiple_choice_responses$Age, na.rm = TRUE)
multiple_choice_responses %>%
  # Filter for rows where Age is between 10 and 90
  filter(between(Age, 10, 90)) %>%
  # Create the generation variable based on age
  mutate(generation = case_when(
    between(Age, 10, 22) ~ "Gen Z", 
    between(Age, 23, 37) ~ "Gen Y", 
    between(Age, 38, 52) ~ "Gen X", 
    between(Age, 53, 71) ~ "Baby Boomer", 
    between(Age, 72, 90) ~ "Silent"
  )) %>%
  # Get a count of how many answers in each generation
  count(generation)
###############################################################
multiple_choice_responses %>%
  # Filter out people who selected Data Scientist as their Job Title
  filter(CurrentJobTitleSelect != "Data Scientist") %>%
  # Create a new variable, job_identity
  mutate(job_identity = case_when(
    CurrentJobTitleSelect == "Data Analyst" & 
      DataScienceIdentitySelect == "Yes" ~ "DS analysts", 
    CurrentJobTitleSelect == "Data Analyst" & 
      DataScienceIdentitySelect %in% c("No", "Sort of (Explain more)") ~ "NDS analyst", 
    CurrentJobTitleSelect != "Data Analyst" & 
      DataScienceIdentitySelect == "Yes" ~ "DS non-analysts", 
    TRUE ~ "NDS non analysts")) %>%
  # Get the average job satisfaction by job_identity, removing NAs
  group_by(job_identity) %>%
  summarize(avg_js = mean(JobSatisfaction, na.rm = TRUE))
###############################################################