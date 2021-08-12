# Load readr
library(readr)
# Load dylyr
library(dplyr)
# Load ggplot2
library(ggplot2)
# Load forcats
library(forcats)
# Load multiple_choice_responses_old dataset
multiple_choice_responses_old <- read_csv("D:/R_data_analyst/Categorical_data_tidyverse/smc_with_js.csv")
multiple_choice_responses_new <- read_csv("D:/R_data_analyst/Categorical_data_tidyverse/multipleChoiceResponses.csv")
###############################################################
# Print out the dataset
print(multiple_choice_responses_old) 
# Check if CurrentJobTitleSelect is a factor
is.factor(multiple_choice_responses_old$CurrentJobTitleSelect)
###############################################################
# Change all the character columns to factors
responses_as_factors <- multiple_choice_responses_old %>%
  mutate_if(is.character, as.factor)
number_of_levels <- responses_as_factors %>%
  # apply the function nlevels to each column
  summarise_all(nlevels) %>%
  # change the dataset from wide to long
  gather(variable, num_levels)
# print first 6 rows
head(number_of_levels)
###############################################################
# Select the 3 rows with the highest number of levels
number_of_levels %>%
  top_n(3, num_levels)
number_of_levels %>%
  # filter for where the column called variable equals CurrentJobTitleSelect
  filter(variable == 'CurrentJobTitleSelect') %>%
  # pull num_levels
  pull(num_levels)
###############################################################
# print first 3 rows
head(responses_as_factors, 3)
responses_as_factors %>%
  # pull CurrentJobTitleSelect
  pull(CurrentJobTitleSelect) %>%
  # get the values of the levels
  levels()
###############################################################
# Make a bar plot
ggplot(multiple_choice_responses_new, aes(EmployerIndustry)) + 
  geom_bar() + 
  # flip the coordinates
  coord_flip()
# Make a bar plot
ggplot(multiple_choice_responses_new, aes(x = fct_infreq(EmployerIndustry))) + 
  geom_bar() + 
  # flip the coordinates
  coord_flip()
# Make a bar plot
ggplot(multiple_choice_responses_new, aes(x = fct_rev(fct_infreq(EmployerIndustry)))) + 
  geom_bar() + 
  # flip the coordinates
  coord_flip()
###############################################################
multiple_choice_responses_new %>%
  # remove NAs
  filter(!is.na(EmployerIndustry) & !is.na(Age)) %>%
  # get mean_age by EmployerIndustry
  group_by(EmployerIndustry) %>%
  summarise(mean_age = mean(Age)) %>%
  # reorder EmployerIndustry by mean_age 
  mutate(EmployerIndustry = fct_reorder(EmployerIndustry, mean_age)) %>%
  # make a scatterplot of EmployerIndustry by mean_age
  ggplot(aes(x = EmployerIndustry, y = mean_age)) + 
  geom_point() + 
  coord_flip()
###############################################################