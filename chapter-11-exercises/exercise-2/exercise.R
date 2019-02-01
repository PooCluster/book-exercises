# Exercise 2: working with `dplyr`
# Note that this exercise repeats the analysis from Exercise 1, but should be 
# performed using `dplyr` (do not directly access or manipulate the data frames)

# Install and load the "fueleconomy" package
#install.packages("devtools")
#devtools::install_github("hadley/fueleconomy")
library(fueleconomy)

# Install and load the "dplyr" library
#install.packages("dplyr")
library("dplyr")

# Select the different manufacturers (makes) of the cars in this data set. 
# Save this vector in a variable
manufacturers <- select(vehicles, make)

# Use the `distinct()` function to determine how many different car manufacturers
# are represented by the data set
print(paste("There are", length(distinct(manufacturers)$make), "unique car manufacturers."))

# Filter the data set for vehicles manufactured in 1997
cars_1997 <- filter(vehicles, year == 1997)

# Arrange the 1997 cars by highway (`hwy`) gas milage
cars_1997 <- arrange(cars_1997, hwy)

# Mutate the 1997 cars data frame to add a column `average` that has the average
# gas milage (between city and highway mpg) for each car
cars_1997 <- mutate(cars_1997, average = (cars_1997$hwy + cars_1997$cty) / 2)

# Filter the whole vehicles data set for 2-Wheel Drive vehicles that get more
# than 20 miles/gallon in the city. 
# Save this new data frame in a variable.
twd_twenty_mg <- filter(vehicles, drive == "2-Wheel Drive", cty > 20)

# Of the above vehicles, what is the vehicle ID of the vehicle with the worst 
# hwy mpg?
# Hint: filter for the worst vehicle, then select its ID.
worst_vehicle_id <- filter(twd_twenty_mg, hwy == min(twd_twenty_mg$hwy))
# There are two ID's, because there are two cars with the same low hwy mpg of 23.

# Write a function that takes a `year_choice` and a `make_choice` as parameters,
# and returns the vehicle model that gets the most hwy miles/gallon of vehicles 
# of that make in that year.
# You'll need to filter more (and do some selecting)!
efficient_car <- function(year_choice, make_choice) {
  available_cars <- filter(vehicles, year == year_choice, make == make_choice)
  available_cars$model[available_cars$hwy == max(available_cars$hwy)]
}

# What was the most efficient Honda model of 1995?
print(paste("The most efficient 1995 Honda is", efficient_car(1995, "Honda")))
