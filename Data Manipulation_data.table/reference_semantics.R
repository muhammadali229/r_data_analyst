# Load data.table
library(data.table)
# Load bikeshare batrips dataset
library(bikeshare14)
batrips <- data.table(batrips)# let's say you want to change the 2nd row of column y to 10
##########################################################
df <- data.frame(x = 1:5, y = 6:10)
df
df$y[2] = 10
df
a <- data.frame(a = 1:3, b = 4:6, c = 7:9, d = 10:12)
a
a[1:2]
a[1:2] <- lapply(a[1:2], function(x) ifelse(x %% 2, x, NA))
a[1:2]
a
###########################################################
# Add a new column, duration_hour
batrips[, duration_hour := duration / 3600]
batrips
# Print untidy
# untidy[1:2]
# Fix spelling in the second row of start_station using the LHS := RHS form
# untidy[2, start_station := "San Francisco City Hall"]
# Replace negative duration values with NA
# untidy[duration < 0, duration := NA ]
############################################################
# Add a new column equal to total trips for every start station
batrips[, trips_N := .N, by = start_station][]
# Add new column for every start_station and end_station
batrips[, duration_mean := mean(duration), by = .(start_station, end_station)][]
# Calculate the mean duration for each month
# batrips_new[, mean_dur :=mean(duration, na.rm = TRUE), 
#            by = month(start_date)]
a <- c(1, 2, 3, 4, NA, 5, 3, NA)
is.na(a)
a[is.na(a)]
# Replace NA values in duration with the mean value of duration for that month
# batrips_new[, mean_dur := mean(duration, na.rm = TRUE), 
#            by = month(start_date)][is.na(duration), 
#                                    duration := mean_dur]
# Delete the mean_dur column by reference
# batrips_new[, mean_dur := mean(duration, na.rm = TRUE), 
#            by = month(start_date)][is.na(duration), 
#                                    duration := mean_dur][, mean_dur := NULL]
#############################################################
# Add columns using the LHS := RHS form
# batrips[, c("mean_duration", "median_duration") := .(mean(duration), median(duration)), 
#        by = start_station]
# Add columns using the functional form
# batrips[, `:=`(mean_duration = mean(duration), median_duration = median(duration)), 
#        by = start_station]
# Add the mean_duration column
batrips[duration > 600, mean_duration := mean(duration), by = .(start_station, end_station)]
batrips
############################################
# Multi-line expressions in j
# batrips[, trip_category :=
#           {
#             med_dur <- median(duration, na.rm = TRUE)
#             if (med_dur < 600) "short"
#             else if (med_dur >= 600 & med_dur <= 1800) "medium"
#             else "long"
#           }, by = .(start_station, end_station)][]

median_duration_bin <- function(duration) {
  med_dur <- median(duration, na.rm = TRUE)
  if (med_dur < 600) "short"
  else if (med_dur >= 600 & med_dur <= 1800) "medium"
  else "long"
}
batrips[, trip_category := median_duration_bin(duration), 
        by = .(start_station, end_station)][]