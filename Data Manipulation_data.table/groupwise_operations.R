# Load data.table
library(data.table)
# Load bikeshare batrips dataset
library(bikeshare14)
batrips <- data.table(batrips)
# Compute the mean duration for every start_station
mean_start_stn <- batrips[, .(mean_duration = mean(duration)),
                          by = .(start_station)]
mean_start_stn
# Compute the mean duration for every start and end station
mean_station <- batrips[, .(mean_duration = mean(duration)), 
                        by = .(start_station, end_station)]
mean_station
# Compute the mean duration grouped by start_station and month
batrips[, .(mean_duration = mean(duration)), 
                              by = .(start_station, month=format(start_date, "%B"))]
################################################################
# Compute mean of duration and total trips grouped by start and end stations
aggregate_mean_trips <- batrips[, .(mean_duration = mean(duration), total_trips = .N),
                                  by = .(start_station, end_station)]
aggregate_mean_trips
# Compute min and max duration grouped by start station, end station, and month
aggregate_min_max <- batrips[, .(min_duration = min(duration), max_duration = max(duration)),  
                             by = .(start_station, end_station,                                                                                      format(start_date, "%B"))]
aggregate_min_max
################################################################
uniqueN(c("a", "a", "b", "c", "c"))
batrips[, .(uniq = uniqueN(bike_id)), by = .(month = format(start_date, "%B"))]
# Arrange the total trips grouped by start_station and end_station in decreasing order
trips_dec <- batrips[, .N, by = .(start_station, 
                                  end_station)][order(N, decreasing=TRUE)]
trips_dec
# Top five most popular destinations
top_5 <- batrips[, .(.N), by = .(end_station)][order(N, decreasing=TRUE)][1:5]
top_5
# Compute most popular end station for every start station
popular_end_station <- trips_dec[, .(end_station = end_station[1]), 
                                 by = .(start_station)]
popular_end_station
# Find the first and last ride for each start_station
first_last <- batrips[, 
                      .(start_date = start_date[c(1,.N)]), 
                      by = .(start_station)]
first_last
#####################################################
x <- data.table(id = c(1,1,2,2,1,1), val1 = 1:6, val2 = letters[6:1])
x
x[, print(.SD), by = .(id)]
x[, .SD[2], by = .(id)]
x[, .SD[.N], by = .(id)]
relevant_cols <- c("start_station", "end_station", 
                   "start_date", "end_date", "duration")

# Find the row corresponding to the shortest trip per month
shortest <- batrips[, .SD[which.min(duration)], 
                    by = month(start_date), 
                    .SDcols = relevant_cols]
shortest
# Find the total number of unique start stations and zip codes per month
unique_station_month <- batrips[, lapply(
  .SD, uniqueN), 
  by = .(month(start_date)), 
  .SDcols = c("start_station", "zip_code")]
unique_station_month