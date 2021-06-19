library(dplyr)
parts <- readRDS("D:/R_data_analyst/joining_data_with_dplyr/parts.rds")
part_categories <- readRDS("D:/R_data_analyst/joining_data_with_dplyr/part_categories.rds")
inventory_parts <- readRDS("D:/R_data_analyst/joining_data_with_dplyr/inventory_parts.rds")
sets <- readRDS("D:/R_data_analyst/joining_data_with_dplyr/sets.rds")
inventories <- readRDS("D:/R_data_analyst/joining_data_with_dplyr/inventories.rds")
colors <- readRDS("D:/R_data_analyst/joining_data_with_dplyr/colors.rds")
glimpse(part_categories)
glimpse(parts)

# Add the correct verb, table, and joining column
parts %>% inner_join(
  part_categories, 
  by=c("part_cat_id"= "id")
)

# Use the suffix argument to replace .x and .y suffixes
parts %>% 
  inner_join(part_categories, by = c("part_cat_id" = "id"), 
             suffix = c("_part", "_category")
  ) %>% count(name_category, sort=TRUE)

glimpse(inventory_parts)
glimpse(parts)

# Combine the parts and inventory_parts tables
parts %>% 
  inner_join(inventory_parts, by = "part_num")

# Combine the parts and inventory_parts tables
inventory_parts %>%
  inner_join(parts, by = "part_num")  

glimpse(sets)
glimpse(inventories)
glimpse(inventory_parts)

sets %>%
  # Add inventories using an inner join 
  inner_join(inventories, by = "set_num") %>%
  # Add inventory_parts using an inner join 
  inner_join(inventory_parts, by = c("id" = "inventory_id"))

glimpse(colors)

# Count the number of colors and sort
sets %>%
  inner_join(inventories, by = "set_num") %>%
  inner_join(inventory_parts, by = c("id" = "inventory_id")) %>%
  inner_join(colors, by = c("color_id" = "id"), suffix = c("_set", "_color")) %>%
  count(name_color, sort = TRUE)
