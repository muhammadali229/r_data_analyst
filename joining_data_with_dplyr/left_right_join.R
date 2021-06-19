library(dplyr)
inventory_parts <- readRDS("D:/R_data_analyst/joining_data_with_dplyr/inventory_parts.rds")
inventories <- readRDS("D:/R_data_analyst/joining_data_with_dplyr/inventories.rds")
parts <- readRDS("D:/R_data_analyst/joining_data_with_dplyr/parts.rds")
part_categories <- readRDS("D:/R_data_analyst/joining_data_with_dplyr/part_categories.rds")
themes <- part_categories <- readRDS("D:/R_data_analyst/joining_data_with_dplyr/themes.rds")
inventory_parts_joined <- inventories %>%
  inner_join(inventory_parts, by = c("id" = "inventory_id")) %>%
  select(-id, -version) %>% # remove id and version
  arrange(desc(quantity))

inventory_parts_joined

millennium_falcon <- inventory_parts_joined %>%
  filter(set_num == "7965-1")

star_destroyer <- inventory_parts_joined %>%
  filter(set_num == "75190-1")

# Combine the star_destroyer and millennium_falcon tables with 
# the suffixes _falcon and _star_destroyer

star_destroyer
millennium_falcon

# Combine the star_destroyer and millennium_falcon tables
millennium_falcon %>%
  left_join(star_destroyer, by = c("part_num", "color_id"), 
            suffix = c("_falcon", "_star_destroyer"))

# Sum the quantity column by color_id in the Millennium Falcon dataset.

# Aggregate Millennium Falcon for the total quantity in each part
millennium_falcon_colors <- millennium_falcon %>%
  group_by(color_id) %>%
  summarize(total_quantity = sum(quantity))

# Aggregate Star Destroyer for the total quantity in each part
star_destroyer_colors <- star_destroyer %>%
  group_by(color_id) %>%
  summarize(total_quantity = sum(quantity))

# Left join the Millennium Falcon colors to the Star Destroyer colors
millennium_falcon_colors %>%
  left_join(star_destroyer_colors, by = "color_id",
            suffix = c("_falcon", "_star_destroyer"))

# Use a left_join to join together sets and inventory_version_1 using their common column.
# filter for where the version column is NA using is.na
inventory_version_1 <- inventories %>%
  filter(version == 1)

# Join versions to sets
sets %>%
  left_join(inventory_version_1, by = "set_num") %>%
  # Filter for where version is na
  filter(is.na(version))

# Counting part colors
parts %>%
  count(part_cat_id) %>%
  right_join(part_categories, by = c("part_cat_id" = "id")) %>%
  # Filter for NA
  filter(is.na(n))

parts %>%
  count(part_cat_id) %>%
  right_join(part_categories, by = c("part_cat_id" = "id")) %>%
  # Use replace_na to replace missing values in the n column
  replace(is.na(.), 0)

themes %>% 
  # Inner join the themes table
  inner_join(themes, by = c("id" = "parent_id"),
             suffix = c("_parent", "_child")) %>%
  # Filter for the "Harry Potter" parent name 
  filter(name_parent == "Harry Potter")

# Join themes to itself again to find the grandchild relationships
themes %>% 
  inner_join(themes, by = c("id" = "parent_id"), suffix = c("_parent", "_child")) %>%# Join themes to itself again to find the grandchild relationships
  inner_join(themes, by = c("id_child" = "parent_id"), suffix = c("_parent", "_grandchild"))

themes %>% 
  # Left join the themes table to its own children
  left_join(themes, by = c("id"= "parent_id"),
            suffix = c("_parent", "_child")) %>%
  # Filter for themes that have no child themes
  filter(is.na(name_child))