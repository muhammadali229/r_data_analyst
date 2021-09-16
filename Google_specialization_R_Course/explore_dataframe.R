library(tidyverse)
library(readxl)
data(diamonds)

# View(diamonds)

head(diamonds)

str(diamonds)

colnames(diamonds)

glimpse(diamonds)

mutate(diamonds, carat_new = carat * 100)

as_tibble(diamonds)

tribble(
  ~name, ~age,
  "John", 24,
  "Micheal", 35
)

readr_example()
read_csv(readr_example("mtcars.csv"))
readxl_example()
excel_sheets(readxl_example("type-me.xlsx"))
read_excel(readxl_example("type-me.xlsx"))