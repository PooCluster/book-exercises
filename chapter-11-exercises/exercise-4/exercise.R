# Exercise 4: practicing with dplyr

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")
library("nycflights13")
library("dplyr")

# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
print(paste(nrow(flights), "rows;", ncol(flights), "cols"))
col_names <- paste(colnames(flights), collapse = ", ")
print (paste("Names of the columns:", col_names))
??flights

# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
flights <- mutate(flights, flight_gain = (sched_arr_time - sched_dep_time) - air_time)
# Tbh, I don't really know what's going on, but I tried best. I think this
# question is asking the difference in actual air time versus expected air
# time. If the number is negative, then the actual air time took longer.

# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
flights <- arrange(flights, -flight_gain)

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame
flights <- flights %>%
  mutate(flight_gain = (sched_arr_time - sched_dep_time) - air_time) %>%
  arrange(-flight_gain)

# Make a histogram of the amount of time gained using the `hist()` function
hist(flights$flight_gain)

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
average_time <- mean(flights$flight_gain, na.rm = TRUE)
# Average air time is lower than expected

# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created
sea_flights <- select(filter(flights, dest == "SEA"), origin, dest, flight_gain)

# On average, did flights to SeaTac gain or loose time?
average_sea_time <- mean(sea_flights$flight_gain, na.rm = TRUE)
# Average air time is higher than expected

# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!
jfk_to_sea <- filter(sea_flights, origin == "JFK")
print(paste("Average:", mean(jfk_to_sea$flight_gain, na.rm = TRUE)))
print(paste("Min:",     min(jfk_to_sea$flight_gain, na.rm = TRUE)))
print(paste("Max:",     max(jfk_to_sea$flight_gain, na.rm = TRUE)))
