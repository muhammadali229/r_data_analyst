# Load data.table
library(data.table)
# Load bikeshare batrips dataset
library(bikeshare14)
batrips <- data.table(batrips)
#############################
class(batrips[, "duration"])
class(batrips[, duration])
# . means list
class(batrips[, .(duration)])
class(batrips[, list(duration)])
######################################
# Select bike_id and trip_id using a character vector
df_way <- batrips[, c("bike_id", "trip_id")]
df_way
# Select start_station and end_station cols without a character vector
dt_way <- batrips[, .(start_station, end_station)]
dt_way
# Deselect start_terminal and end_terminal columns
drop_terminal_cols <- batrips[, !c("start_terminal", "end_terminal")]
drop_terminal_cols
#######################################
# Calculate median duration using the j argument
median_duration <- batrips[, median(duration)]
median_duration
# Get median duration after filtering
median_duration_filter <- batrips[
  end_station == "Market at 10th" & subscription_type == "Subscriber",
  median(duration)
]
median_duration_filter
# Compute duration of all trips
trip_duration <- batrips[, difftime(end_date, start_date, "min")]
head(trip_duration)
###########################################
# Calculate the average duration as mean_durn
mean_duration <- batrips[, .(mean_durn = mean(duration))]
mean_duration
# Get the min and max duration values
min_max_duration <- batrips[, .(min(duration), max(duration))]
min_max_duration
# Calculate the average duration and the date of the last ride
other_stats <- batrips[, .(mean_duration = mean(duration),
                           last_ride = max(end_date))]
other_stats
# Calculate the minimum and maximum duration for all trips 
#where the start_station is "Townsend at 7th" and the duration is less than 500. Rename these columns to min_dur and max_dur, respectively.
duration_stats <- batrips[start_station == "Townsend at 7th" &
                            duration < 500, 
                          .(min_dur = min(duration), 
                            max_dur = max(duration))]
duration_stats
# Plot the histogram of duration based on conditions
batrips[start_station == "Townsend at 7th" & duration < 500, hist(duration)]