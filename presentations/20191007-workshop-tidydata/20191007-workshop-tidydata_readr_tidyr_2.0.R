

# Load libraries
library(tidyverse)
library(gapminder)

# Importing data ----------------------------------------------------------

read_csv("billboard.csv")
data <- read_csv("billboard.csv")

data

glimpse(data)

# Tidyr -------------------------------------------------------------------

# 'Wide' data
table4a

# gather- makes 'wide' data 'long'

table4a %>% 
  gather(year, cases, 2:3)


# 'Long' data
table2

# Spread -makes 'long' data 'wide'
table2 %>% 
  spread(type,count)


# Make data from wide to long ---------------------------------------------

long <- data %>%
  gather(week, rank, 4:79, na.rm = TRUE)

long

#names(long) [3] <- "Date"

# Split single column to multiple columns ---------------------------------
## Remove prename "wk" from values and split date into columns Y, M,D.
split <- long %>%
  separate(week, into = c(NA, "Week"), sep = "wk") %>%
  separate(date.entered, into = c("Year", "Month", "Day"), sep = "-")

split

#Unite multiple columns to single column -----------------------------

split %>%
  unite("YYYY-MM", c("Year","Month"), sep = "-", remove = FALSE)

# Export data -------------------------------------------------------------

write_csv(split, "Tidy_demo_billboard.csv")
