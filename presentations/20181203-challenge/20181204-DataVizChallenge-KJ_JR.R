################################################################################
## Created by: Kayla Johnson & Janani Ravi
## Created on Dec 03, 2018
## Data Viz #TidyTuesday Challenge
## https://github.com/rfordatascience/tidytuesday/master/data/2018-11-06
################################################################################

## Libraries to be loaded
library(tidyverse)
library(maps)    # install.packages("maps")
library(mapproj) # install.packages("maps")

## Reading data
wind <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2018-11-06/us_wind.csv", na=c("missing", "-9999", -9999, NA, N/A, "n/a"))

summary(wind$p_year)

# A painful way of attacking missing values one column at a time!
# Avoid doing this!
# wind$p_year <- str_replace_all(string=as.character(wind$p_year),
#                                pattern="-9999",
#                                replacement="NA") %>%
#   as.numeric()

summary(wind$p_year)

wind.post2008 <- wind %>%
  filter(p_year>=2008)
wind.pre2008 <- wind %>%
  filter(p_year<2008)

wind.new <- wind %>%
  mutate(age=if_else(p_year>=2008,"new", "old"))

wind.new %>%
  select(p_year, age) %>%
  ggplot(aes(y=p_year, x=age)) +
  geom_boxplot() + coord_flip()

# Q1: age of the project vs turbine capacity
wind.new %>%
  filter(t_cap>=0, p_year>=0) %>%
  ggplot(aes(x=age, y=t_cap)) +
  geom_boxplot()


# Q2: map

## alternate approach
# wind.new %>%
#   group_by(t_state) %>%
#   summarize(n=sum(p_tnum)) %>%
#   arrange(-n)

wind.new %>%
  group_by(t_state) %>%
  tally(p_tnum, sort=T) %>%
  ggplot(aes(x=xlong, y=ylat, size=p_tnum)) %>%
  borders("state") +
  geom_point() + coord_map()


ggplot(wind.state.tally, aes(map_id=t_state)) +
  geom_map(aes(fill=n), map=map_data("state"))

# Better example
crimes <- data.frame(state = tolower(rownames(USArrests)), USArrests)
crimesm <- reshape2::melt(crimes, id = 1)
if (require(maps)) {
  states_map <- map_data("state")
  ggplot(crimes, aes(map_id = state)) +
    geom_map(aes(fill = Murder), map = states_map) +
    expand_limits(x = states_map$long, y = states_map$lat)

  last_plot() + coord_map()
  ggplot(crimesm, aes(map_id = state)) +
    geom_map(aes(fill = value), map = states_map) +
    expand_limits(x = states_map$long, y = states_map$lat) +
    facet_wrap( ~ variable)
}