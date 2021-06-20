library(dplyr)
library(tidyr)
library(ggplot2)
library(forcats)
library(lubridate)
questions <- readRDS("D:/R_data_analyst/joining_data_with_dplyr/questions.rds")
question_tags <- readRDS("D:/R_data_analyst/joining_data_with_dplyr/question_tags.rds")
tags <- readRDS("D:/R_data_analyst/joining_data_with_dplyr/tags.rds")
answers <- readRDS("D:/R_data_analyst/joining_data_with_dplyr/answers.rds")

# Left-joining questions and tags
glimpse(questions)
glimpse(question_tags)
glimpse(tags)

# Join the questions and question_tags tables
questions_with_tags <- questions %>%
  left_join(question_tags, by = c("id" = "question_id")) %>%
  # join tags
  left_join(tags, by = c('tag_id' = 'id')) %>%
  # replace missing values in tag_name to 'only-r'
  replace_na(list(tag_name = 'only-r'))

glimpse(questions_with_tags)

# Comparing scores across tags
# find out the average score of the most asked questions.
questions_with_tags %>%
  # Group by tag_name
  group_by(tag_name) %>%
  # Get mean score and num_questions
  summarize(score = mean(score),
            num_questions = n()) %>%
  # Sort num_questions in descending order
  arrange(desc(num_questions))

# What tags never appear on R questions?
# Using a join, filter for tags that are never on an R question
tags %>%
  anti_join(question_tags, by = c('id' = 'tag_id'))

# Finding gaps between questions and answers
glimpse(questions)
glimpse(answers)

questions %>%
  # Inner join questions and answers with proper suffixes
  inner_join(answers, by = c('id' = 'question_id'), suffix = c('_question', '_answer')) %>%
  # Subtract creation_date_question from creation_date_answer to create gap
  mutate(gap = as.integer(creation_date_answer - creation_date_question))

# joining question and answer counts

# Count and sort the question id column in the answers table
answer_counts <- answers %>%
  count(question_id, sort=TRUE)
  
  # Combine the answer_counts and questions tablesquestion_answer_countsz
question_answer_counts <-  questions %>%
  left_join(answer_counts, by = c('id' = 'question_id')) %>%
  # Replace the NAs in the n column
  replace_na(list(n = 0))
  
# Joining questions, answers, and tags
tagged_answers <-  question_answer_counts %>%
    # Join the question_tags tables
    inner_join(question_tags, by = c('id' = 'question_id')) %>%
    # Join the tags table
    inner_join(tags, by = c('tag_id' = 'id'))

# Average answers by question
tagged_answers %>%
  # Aggregate by tag_name
  group_by(tag_name) %>%
  # Summarize questions and average_answers
  summarize(questions = n(),
            average_answers = mean(n)) %>%
  # Sort the questions in descending order
  arrange(desc(questions))

# Joining questions and answers with tags
# Inner join the question_tags and tags tables with the questions table
questions_with_tags <- questions %>%
  inner_join(question_tags, by = c('id' = 'question_id')) %>%
  inner_join(tags, by = c('tag_id'= 'id'))

# Inner join the question_tags and tags tables with the answers table
answers_with_tags <- answers %>%
  inner_join(question_tags, by = 'question_id') %>%
  inner_join(tags, by = c('tag_id' = 'id'))
  
# Binding and counting posts with tags
# Combine the two tables into posts_with_tags
posts_with_tags <- bind_rows(questions_with_tags %>% mutate(type = "question"),
                       answers_with_tags %>% mutate(type = "answer"))


# Add a year column, then aggregate by type, year, and tag_name
by_type_year_tag <- posts_with_tags %>%
  mutate(year = year(creation_date)) %>%
  count(type, year, tag_name)

# Filter for the dplyr and ggplot2 tag names 
by_type_year_tag_filtered <- by_type_year_tag %>%
  filter(tag_name %in% c('dplyr', 'ggplot2') )

# Create a line plot faceted by the tag name 
ggplot(by_type_year_tag_filtered, aes(year, n, color = type)) +
  geom_line() +
  facet_wrap(~ tag_name)


  