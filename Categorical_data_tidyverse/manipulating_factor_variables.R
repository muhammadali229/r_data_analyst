# Load tidyr
library(readr)
# Load dylyr
library(dplyr)
# Load ggplot2
library(ggplot2)
# Load forcats
library(forcats)
# Load multiple_choice_responses_old dataset
#multiple_choice_responses_old <- read_csv("D:/R_data_analyst/Categorical_data_tidyverse/smc_with_js.csv")
multiple_choice_responses <- read_csv("D:/R_data_analyst/Categorical_data_tidyverse/multipleChoiceResponses.csv")
multiple_choice_responses <- multiple_choice_responses %>%
  mutate_if(is.character, as.factor)
###############################################################
# Get the levels of WorkInternalVsExternalTools
levels(multiple_choice_responses$WorkInternalVsExternalTools)

# Reorder the levels from internal to external 
mc_responses_reordered <- multiple_choice_responses %>%
  mutate(WorkInternalVsExternalTools = fct_relevel(WorkInternalVsExternalTools,
                                                   "Entirely internal", 
                                                   "More internal than external",
                                                   "Approximately half internal and half external",
                                                   "More external than internal", 
                                                   "Entirely external",
                                                   'Do not know'))
# Make a bar plot of the responses
ggplot(mc_responses_reordered, aes(WorkInternalVsExternalTools)) + 
  geom_bar() + 
  coord_flip()
###############################################################
levels(multiple_choice_responses$FormalEducation)
multiple_choice_responses %>%
  # Move "I did not complete any formal education past high school" and "Some college/university study without earning a bachelor's degree" to the front
  mutate(FormalEducation = fct_relevel(FormalEducation, 'I did not complete any formal education past high school', "Some college/university study without earning a bachelor's degree")) %>%
  # Move "I prefer not to answer" to be the last level.
  mutate(FormalEducation = fct_relevel(FormalEducation, 'I prefer not to answer', after = Inf)) %>%
  # Move "Doctoral degree" to be after the 5th level
  mutate(FormalEducation = fct_relevel(FormalEducation, 'Doctoral degree', after = 5)) %>%
  # Examine the new level order
  pull(FormalEducation) %>%
  levels()
###############################################################
# make a bar plot of the frequency of FormalEducation
ggplot(multiple_choice_responses, aes(FormalEducation)) + 
  geom_bar()
multiple_choice_responses %>%
  # rename the appropriate levels to "High school" and "Some college"
  mutate(FormalEducation = fct_recode(FormalEducation,
                                      'High school' = "I did not complete any formal education past high school", 
                                      'Some college' = "Some college/university study without earning a bachelor's degree")) %>%
  # make a bar plot of FormalEducation
  ggplot(aes(x = FormalEducation)) + 
  geom_bar() +
  coord_flip()
###############################################################
levels(multiple_choice_responses$CurrentJobTitleSelect)
multiple_choice_responses %>%
  # Create new variable, grouped_titles, by collapsing levels in CurrentJobTitleSelect
  mutate(grouped_titles = fct_collapse(CurrentJobTitleSelect, 
                                       "Computer Scientist" = c("Programmer", "Software Developer/Software Engineer"), 
                                       "Researcher" = "Scientist/Researcher", 
                                       "Data Analyst/Scientist/Engineer" = c("DBA/Database Engineer", "Data Scientist", 
                                                                             "Business Analyst", "Data Analyst", 
                                                                             "Data Miner", "Predictive Modeler"))) %>%
  # Keep all the new titles and turn every other title into "Other"
  mutate(grouped_titles = fct_other(grouped_titles, 
                                    keep = c("Computer Scientist", 
                                             "Researcher", 
                                             "Data Analyst/Scientist/Engineer"))) %>% 
  # Get a count of the grouped titles
  count(grouped_titles)
###############################################################
multiple_choice_responses %>%
  # remove NAs of MLMethodNextYearSelect
  filter(!is.na(MLMethodNextYearSelect)) %>%
  # create ml_method, which lumps all those with less than 5% of people into "Other"
  mutate(ml_method = fct_lump(MLMethodNextYearSelect, prop = 0.05)) %>%
  # count the frequency of your new variable, sorted in descending order
  count(ml_method, sort = TRUE)
###############################################################
multiple_choice_responses %>%
  # remove NAs 
  filter(!is.na(MLMethodNextYearSelect)) %>%
  # create ml_method, retaining the 5 most common methods and renaming others "other method" 
  mutate(ml_method = fct_lump(MLMethodNextYearSelect, n = 5, other_level = 'other method')) %>%
  # count the frequency of your new variable, sorted in descending order
  count(ml_method, sort = TRUE)
###############################################################