# Exercise 6: dplyr join operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

# Create a dataframe of the average arrival delays for each _destination_, then 
# use `left_join()` to join on the "airports" dataframe, which has the airport
# information
# Which airport had the largest average arrival delay?
avg_arr_del_by_dest <- flights %>%
  group_by(dest) %>%
  summarize(avg_arr_del = mean(arr_delay, na.rm = TRUE)) %>%
  arrange(-avg_arr_del)
avg_arr_del_by_dest <- left_join(avg_arr_del_by_dest, airports, by = c("dest" = "faa"))

most_delayed_airport <- avg_arr_del_by_dest %>%
  filter(avg_arr_del == max(avg_arr_del)) %>%
  select(name)
print(paste(most_delayed_airport, "is the airport with the largest average arrival delay."))

# Create a dataframe of the average arrival delay for each _airline_, then use
# `left_join()` to join on the "airlines" dataframe
# Which airline had the smallest average arrival delay?
avg_arr_del_by_airline <- flights %>%
  group_by(carrier) %>%
  summarize(avg_arr_del = mean(arr_delay, na.rm = TRUE)) %>%
  arrange(-avg_arr_del)
avg_arr_del_by_airline <- left_join(avg_arr_del_by_airline, airlines, by = "carrier")

least_delayed_airline <- avg_arr_del_by_airline %>%
  filter(avg_arr_del == min(avg_arr_del)) %>%
  select(name)
print(paste(least_delayed_airline, "is the airline with the smallest average arrival delay."))
