#########################################
#                                       #
#              Lecture 04               #
#                                       #
#    Introduction to data-munging       #
#                                       #
#   - Add new manipulated variables     #
#   - Separate char to new variables    #
#   - Convert variables to              #
#       numeric or factor               #
#   - Some string manipulations         #
#   - Rename variables                  #
#   - Filter out different observations #
#     - conditional selection           #
#     - tabulate frequency of a var     #
#     - missing values                  #
#     - replace values                  #
#     - duplicates                      #
#   - Using pipies: %>%                 #
#   - Sorting data                      #
#                                       #
# Case-study:                           #
# Based on: Chapter 02, A:              #
#     Finding a good deal among hotels: #
#         data preparation              #
#                                       #
# Dataset:                              #
#   hotels-europe                       #
#                                       #
#########################################

#
# Data Munging with hotel-europe data

rm(list = ls())
library(tidyverse)

# Import raw data
raw_df <- read_csv('https://osf.io/yzntm/download')

# as this is a large file you may want to save it:
# data_dir <- paste0(getwd(), '/data/')
# write_csv(raw_df, paste0(data_dir, '/raw/hotelbookingdata.csv'))

# Have glimpse on data
glimpse(raw_df)

###
# 1) Adding a new variable:
#  let us add nnights variable, which shows the number of nights spent in the hotel
#   as the data was collected in such way, it is 1 for each observations.

# to create a new variable, you can use `mutate()` function from tidyverse - dplyr
df <- mutate(raw_df, nnights = 1)

# Let us remove raw_df
rm(raw_df)

###
# Data cleaning
#
# 2) Selecting a variable
select(df, accommodationtype)
# or multiple variables
select(df, accommodationtype, price)

# Note: $ sign selects the vector, but only one variable can be selected. 
# Also note that it will result in a vector and not tibble variable!
df$accommodationtype

##
# 3) separating character vector with a unique sign 
#
# Check accomotationtype: it is a character with a clear separator '@'
#
# To clean accommodationtype column: separate the characters at @ 
#   and create two new variables: 'garbage' and 'acc_type'.
# garbage will contain all characters before @ sign and acc_type will take everything after!

# with tidyverse it is simple, use:
#   `separate(data, variable, separator, into = c(var1, var2))` 
df <- separate(df, accommodationtype, '@' ,
                into = c('garbage','acc_type'))

# Check the two new variable, and that `accommodationtype` is removed.

# We can remove the variable garbage, as we will not need it any more.
df <- select(df, -garbage)

###
# De-tour: factor variables:
#   - factor variable is a special variable consists factor R-objects.
#     - its main purpose is to:
#       a) allow only certain values
#       b) handle this variable differently as a categorical (or even a ordinal) variable.

# Create a factor variable for acc_type (use of factors will be clear in the next class)
df <- mutate(df, acc_type = factor(acc_type))
# check if it is a factor
is.factor(df$acc_type)

# It is possible to set different (optional) properties of the factors:
#   - levels = c() -> can define the different values
#   - labels = c() -> can change the name of levels to show. E.g.: lvl1 ---> level-1
#                       Handy for creating nice graphs, but coding with short names
#   - ordered = c() -> will tell R it is an ordered list.
#
# here we are going to skip these properties as they are not widely used during the course,
#   but it is good to know.

##
# Task - creating a numeric vector w simple separation
#   1) Correct the guestreviewsrating into simple numeric variable
#   2) check with `typeof()`
#   3) convert the variable into a numeric variable




####
# Good-to-know:
#   Advanced string manipulations:
#
#
# Let us create a numeric vector with more complicated, but general separation:
#
# Check the distance measure:
df$center1distance
# we have two numeric values than the format of the distance 'miles'

# to get it right let us check first how to find patterns in characters:
eg1 <- 'Coding is 123 fun!'
# Find numeric values in a vector and replace it: gsub(find,replace,variable):
gsub('12', 'extra fun', eg1)
# Find and replace any numeric value in a simple expression
gsub('[0-9\\.]',' extra fun,', eg1)
# Find all non-numeric values (negate with `^` sign) and replace with '' (none -> remove it)
gsub('[^0-9\\.]','', eg1)

# Create two new numeric vectors using the distance measures with gsub
df <- mutate(df, 
              distance = as.numeric(gsub('[^0-9\\.]','', center1distance)),
              distance_alter = as.numeric(gsub('[^0-9\\.]','', center2distance)))

# Note: it will not remove the original variables

##
# Task:
#  1) use separate() command instead of mutate and gsub (utilize that the decimals are not changing)
#  2) do not forget to change the type! 


###
## Rename variables
# with tidy approach it is recommended to use human-readable vector names as well!
df <- rename(df, rating_count = rating_reviewcount,
              ratingta = rating2_ta)
##
# Task:
#   also rename the following variables as follows:
#       ratingta_count = rating2_ta_reviewcount,
#       country = addresscountryname,
#       stars = starrating,
#       city = s_city



####
## Filtering observations
#
# use of filter()

# let us have only hotels:
filter(df, acc_type == 'Hotel')


##
# Filtering: find missing values
# look at one of our key variable: ratings
# we can tabulate the frequencies of the ratings
table(df$ratings, useNA = 'ifany')
# What can we do with the NA values?
# First check them with 'filter'
filter(df, is.na(ratings))
# if reasonable we can drop them, but there needs to be good reason for that!
df <- filter(df, !is.na(ratings))

# alternatively you can use `df <- drop_na(df, ratings)`

##
# Task:
# Do the same for missing id-s and argue what to do with them! 


###
## Correcting wrongly documented observations:
# In case of `stars` there are only values from 0-5
table(df$stars, useNA = 'ifany')
# what does 0 star means? It is missing, but recorded as 0...
# we need to set these values to NA: re-define the stars variable:
df <- mutate(df, stars = na_if(stars, 0))
table(df$stars, useNA = 'ifany')


###
## Duplicates:
# 1) exact match for each values for a given observations
# Count the number of duplicates
sum(duplicated(df))
# Remove duplicates
df <- filter(df, !duplicated(df))

# 2) Remove duplicates to specific variables, that are important to us
#  To make sense, let us take this into two steps:
#   a) select certain variables:
imp_vars <- select(df, country, hotel_id)

# Now we can filter out only duplicates in these variables:
df <- filter(df, !duplicated( select(df, country,hotel_id, 
                                         distance,
                                         stars, 
                                         ratings, 
                                         price, 
                                         year, 
                                         month,
                                         weekend, 
                                         holiday )))

###
## Task: Get specific data used in DA1 course:
#   1) Get hotels only from Vienna
#   2) Filter out the following observations:
#       - in date: 2017, November and 0s week (multiple conditions)
#       - with Hotel types which has stars between 3 and 4
#       - and drop observations which has price more than 1000 EUR.



###
# Pipes in tidyverse
#
# tidyverse allows 'pipes' which is a great and intuitive programming expression:
# It allows to make multiple sequential manipulations with one command:
# use `%>%` which says: take obj1 %>% do manipulations.

# E.g. filter out Vienna from df:
df %>% filter(city == 'Vienna')

# Or do multiple filters:
df %>% filter(city == 'Vienna') %>% 
  filter(year == 2017 & month == 11 & weekend == 0)

# But the great advantage is that you can use different functions e.g.
df %>% filter(city == 'Vienna') %>%
  select(city, distance) %>% 
  rename(town = city)

# %>% has a hotkey of `cmd+shift+m` on mac and `ctrl+shift+m` on windows

##
# Make data table more `pretty`
# Can arrange the values in increasing order
hotel_vienna <- arrange(hotel_vienna, price)
# in case of decreasing order
hotel_vienna <- arrange(hotel_vienna, desc(price))


# Task: writing out csv as clean data

