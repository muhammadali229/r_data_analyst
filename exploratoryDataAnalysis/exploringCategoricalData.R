library(readr)
library(dplyr)
library(ggplot2)
# Load comics dataset
comics <- read_csv("D:/R_data_analyst/exploratoryDataAnalysis/comics.csv")
head(comics)
##########################################################################
# Print the first rows of the data
comics
# Check levels of align
levels(comics$align)
# Check the levels of gender
levels(comics$gender)
# Create a 2-way contingency table
table(comics$align, comics$gender)
##########################################################################
tab <- table(comics$align, comics$gender)
# Print tab
tab
# Remove align level
comics_filtered <- comics %>%
  filter(align != "Reformed Criminals") %>%
  droplevels()
# See the result
comics_filtered
##########################################################################
# Create side-by-side barchart of gender by alignment
ggplot(comics, aes(x = align, fill = gender)) + 
  geom_bar(position = "dodge")
# Create side-by-side barchart of alignment by gender
ggplot(comics, aes(x = gender, fill = align)) + 
  geom_bar(position = "dodge") +
  theme(axis.text.x = element_text(angle = 90))
##########################################################################
tab <- table(comics$align, comics$gender)
options(scipen = 999, digits = 3) # Print fewer digits
prop.table(tab)     # Joint proportions
prop.table(tab, 2)  # Conditional on columns
##########################################################################
# Plot of gender by align
ggplot(comics, aes(x = align, fill = gender)) +
  geom_bar()

# Plot proportion of gender, conditional on align
ggplot(comics, aes(x = align, fill = gender)) + 
  geom_bar(position = "fill") +
  ylab("proportion")
##########################################################################
# Change the order of the levels in align
comics$align <- factor(comics$align, 
                       levels = c("Bad", "Neutral", "Good"))# Create plot of align
ggplot(comics, aes(x = align)) + 
  geom_bar()
##########################################################################
# Plot of alignment broken down by gender
ggplot(comics, aes(x = align)) + 
  geom_bar() +
  facet_wrap(~ gender)
##########################################################################

##########################################################################
