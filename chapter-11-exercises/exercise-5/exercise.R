# Exercise 5: dplyr grouped operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

# What was the average departure delay in each month?
# Save this as a data frame `dep_delay_by_month`
# Hint: you'll have to perform a grouping operation then summarizing your data
dep_delay_by_month <- summarize(flights,
                                jan = mean(flights$dep_delay[flights$month == 1],  na.rm = TRUE),
                                feb = mean(flights$dep_delay[flights$month == 2],  na.rm = TRUE),
                                mar = mean(flights$dep_delay[flights$month == 3],  na.rm = TRUE),
                                apr = mean(flights$dep_delay[flights$month == 4],  na.rm = TRUE),
                                may = mean(flights$dep_delay[flights$month == 5],  na.rm = TRUE),
                                jun = mean(flights$dep_delay[flights$month == 6],  na.rm = TRUE),
                                jul = mean(flights$dep_delay[flights$month == 7],  na.rm = TRUE),
                                aug = mean(flights$dep_delay[flights$month == 8],  na.rm = TRUE),
                                sep = mean(flights$dep_delay[flights$month == 9],  na.rm = TRUE),
                                oct = mean(flights$dep_delay[flights$month == 10], na.rm = TRUE),
                                nov = mean(flights$dep_delay[flights$month == 11], na.rm = TRUE),
                                dec = mean(flights$dep_delay[flights$month == 12], na.rm = TRUE))


# Which month had the greatest average departure delay?
print(paste("July has the greatest average departure delay:", dep_delay_by_month$jul))

# If your above data frame contains just two columns (e.g., "month", and "delay"
# in that order), you can create a scatterplot by passing that data frame to the
# `plot()` function
# I have 12 different columns.

# To which destinations were the average arrival delays the highest?
# Hint: you'll have to perform a grouping operation then summarize your data
# You can use the `head()` function to view just the first few rows
dest_avg_arrr_del <- flights %>%
  group_by(dest) %>%
  summarize(avg_del = mean(arr_delay, na.rm = TRUE)) %>%
  arrange(-avg_del)

# You can look up these airports in the `airports` data frame!


# Which city was flown to with the highest average speed?

