library(here)
library(skimr)
library(janitor)
library(tidyr)
library(palmerpenguins)

skim_without_charts(penguins)
glimpse(penguins)
head(penguins)

select(penguins, species)
penguins %>%
  select(-species)

penguins %>%
  rename(island_new = island)

rename_with(penguins, toupper)

# This includes only characters, numbers and _ in the col names
clean_names(penguins)

####################################
x <- 2

y <- 5
y %/% x

x <- 10
x > 2 & x < 12
x > 2 | x < 8
####################################
x <- c(3, 5, 7)
y <- c(2, 4, 6)
x < 5 & y < 5
# In this case R is only compare the first element of each vector 
x < 5 && y < 5
####################################
penguins %>% 
  arrange(bill_length_mm)
penguins2 <- penguins %>% 
  arrange(-bill_length_mm)
penguins2 %>% 
  group_by(island) %>% 
  drop_na() %>% 
  summarize(
    mean_bill_length_mm = mean(bill_length_mm),
    max_bill_length_mm = max(bill_length_mm)
    )
penguins2 %>% 
  group_by(species, island) %>% 
  drop_na() %>% 
  summarize(
    mean_bill_length_mm = mean(bill_length_mm),
    max_bill_length_mm = max(bill_length_mm)
  )
penguins2 %>% 
  filter(species == "Adelie")
####################################
id <- c(1:10)

name <- c("John Mendes", "Rob Stewart", "Rachel Abrahamson", "Christy Hickman", "Johnson Harper", "Candace Miller", "Carlson Landy", "Pansy Jordan", "Darius Berry", "Claudia Garcia")

job_title <- c("Professional", "Programmer", "Management", "Clerical", "Developer", "Programmer", "Management", "Clerical", "Developer", "Programmer")

employee <- data.frame(id, name, job_title)

View(employee)

sep_data <- separate(employee, name, c("first_name", "last_name"), sep = " ")
View(sep_data)
unite_data <- unite(sep_data, "name", first_name, last_name, sep = " ")
View(unite_data)