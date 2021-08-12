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
# Load flying_etiquette dataset
flying_etiquette <- read_csv("D:/R_data_analyst/Categorical_data_tidyverse/flying-etiquette.csv") 
###############################################################
flying_etiquette %>%
  # Change characters to factors
  mutate_if(is.character, as.factor) %>%
  # Filter out those who have never flown on a plane
  filter(`How often do you travel by plane?` != 'Never')
###############################################################
gathered_data <- flying_etiquette %>%
  mutate_if(is.character, as.factor) %>%
  filter(`How often do you travel by plane?` != "Never") %>%
  # Select columns containing "rude"
  select(contains('rude')) %>%
  # Change format from wide to long
  gather(response_var, value)
# print first 6 rows of gathered_data
head(gathered_data)
###############################################################
gathered_data %>%
  # Remove everything before and including "rude to " (with that space at the end!)
  mutate(response_var = str_remove(response_var, '.*rude to ')) %>%
  # Remove "on a plane"
  mutate(response_var = str_remove(response_var, 'on a plane'))
###############################################################
dichotimized_data <- gathered_data %>%
  mutate(response_var = str_replace(response_var, '.*rude to ', '')) %>%
  mutate(response_var = str_replace(response_var, 'on a plane', '')) %>%
  # Remove rows that are NA in the value column
  filter(!is.na(value)) %>%
  # Dichotomize the value variable to make a new variable, rude
  mutate(rude = if_else(value %in% c('No, not rude at all', 'No, not at all rude'), 0, 1))
# print first 6 rows of dichotimized_data
head(dichotimized_data)
###############################################################
rude_behaviors <- gathered_data %>%
  mutate(response_var = str_replace(response_var, '.*rude to ', '')) %>%
  mutate(response_var = str_replace(response_var, 'on a plane', '')) %>%
  # Remove rows that are NA in the value column
  filter(!is.na(value)) %>%
  mutate(rude = if_else(value %in% c("No, not rude at all", "No, not at all rude"), 0, 1)) %>%
  # Group by response_var
  group_by(response_var) %>%
  # Create perc_rude, the percent considering each behavior rude
  summarize(perc_rude = mean(rude))
rude_behaviors
###############################################################
initial_plot <- rude_behaviors %>%
  # reorder response_var by perc_rude
  mutate(response_var = fct_reorder(response_var, perc_rude)) %>%
  # make a bar plot of perc_rude by response_var
  ggplot(aes(x = response_var, y = perc_rude)) + 
  geom_col()
# View your plot
initial_plot
###############################################################
titled_plot <- initial_plot + 
  # Add the title, subtitle, and caption
  labs(title = "Hell Is Other People In A Pressurized Metal Tube",
       subtitle = "Percentage of 874 air-passenger respondents who said action is very or somewhat rude",
       caption = "Source: SurveyMonkey Audience", 
       # Remove the x- and y-axis labels
       x = "", 
       y = "") 
titled_plot
###############################################################
flipped_plot <- titled_plot + 
  # Flip the axes
  coord_flip() + 
  # Remove the x-axis ticks and labels
  theme(axis.text.x = element_blank(), 
        axis.ticks.x = element_blank())
###############################################################
flipped_plot + 
  # Apply percent() to perc_rude to label above the bar with the perc value
  geom_text(aes(label = scales::percent(perc_rude), 
                y = perc_rude + .05), 
            position = position_dodge(0.9),
            vjust = 1)
###############################################################