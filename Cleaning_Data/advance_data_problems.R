library(dplyr)
library(stringr)
library(lubridate)
library(ggplot2)
library(visdat)
library(assertive)
accounts <- readRDS("D:/R_data_analyst/Cleaning_Data/ch3_1_accounts.rds")
##########################################################################
# Check out the accounts data frame
head(accounts)
# By default, as.Date() can't convert "Month DD, YYYY" formats.
as.Date(accounts$date_opened)
# Define the date formats
formats <- c("%Y-%m-%d", "%B %d, %Y")
# Convert dates to the same format
accounts %>%
  mutate(date_opened_clean = parse_date_time(date_opened, formats))
##########################################################################
# # Scatter plot of opening date and total amount
accounts %>%
  ggplot(aes(x = date_opened, y = total)) +
  geom_point()
# Left join accounts and account_offices by id
# accounts %>%
#   left_join(account_offices, by = "id")
# # Left join accounts to account_offices by id
# accounts %>%
#   left_join(account_offices, by = "id") %>%
#   # Convert totals from the Tokyo office to USD
#   mutate(total_usd = ifelse(office == "Tokyo", total / 104, total)) %>%
# Scatter plot of opening date vs total_usd
# ggplot(aes(x = date_opened, y = total_usd)) +
#   geom_point()
##########################################################################
# Find invalid totals
# accounts %>%
#   # theoretical_total: sum of the three funds
#   mutate(theoretical_total = fund_A + fund_B + fund_C) %>%
#   # Find accounts where total doesn't match theoretical_total
#   filter(total != theoretical_total)
##########################################################################
# Find invalid acct_age
# accounts %>%
#   # theoretical_age: age of acct based on date_opened
#   mutate(theoretical_age = floor(as.numeric(date_opened %--% today(), "years"))) %>%
#   # Filter for rows where acct_age is different from theoretical_age
#   filter(theoretical_age != acct_age)
##########################################################################
# Visualize the missing values by column
# vis_miss(accounts)
# Visualize the missing values by column
# accounts %>%
#   # missing_inv: Is inv_amount missing?
#   mutate(missing_inv = is.na(inv_amount)) %>%
#   # Group by missing_inv
#   group_by(missing_inv) %>%
#   # Calculate mean age for each missing_inv group
#   summarize(avg_age = mean(age))
# Since the average age for TRUE missing_inv is 22 and 
# the average age for FALSE missing_inv is 44, it is 
# likely that the inv_amount variable is missing mostly 
# in young customers.
# Sort by age and visualize missing vals
# accounts %>%
#   arrange(age) %>%
#   vis_miss()
##########################################################################
# Create accounts_clean
# accounts_clean <- accounts %>%
#   # Filter to remove rows with missing cust_id
#   filter(!is.na(cust_id))
# accounts_clean
# Create accounts_clean
# accounts_clean <- accounts %>%
#   # Filter to remove rows with missing cust_id
#   filter(!is.na(cust_id)) %>%
#   # Add new col acct_amount_filled with replaced NAs
#   mutate(acct_amount_filled = ifelse(is.na(acct_amount), 5 * inv_amount , acct_amount))
# accounts_clean
# Assert that cust_id has no missing vals
# assert_all_are_not_na(accounts_clean$cust_id)
# Assert that acct_amount_filled has no missing vals
# assert_all_are_not_na(accounts_clean$acct_amount_filled)
# str_remove(" nice way of talking", " ")
str_trim(" nice way of talking")
