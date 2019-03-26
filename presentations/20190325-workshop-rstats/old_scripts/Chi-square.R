
## Installing packages
install.packages("ggpubr")
install.packages("lsr")
install.packages("ggplot2")
install.packages("pwr")
install.packages("stats")

# Loading packages
library(tidyverse)
library(ggplot2)
library(dplyr)
library(lsr)
library(car)
library(pwr)
library(stats)

# Load gapminder package (contains built-in dataset of world populations, life expectancy, and GDP)
library(gapminder)

#Viewing the data:
View(gapminder)

#Prepare the data
#Select 2007 data, create categorical variables based on mean gdpPercap and lifeExp

gapminder_2007 <- gapminder %>% 
  filter(year == "2007") %>% 
  mutate(gdp_factor = if_else(gdpPercap > mean(gdpPercap), "high gdp", "low gdp"), 
         life_exp_factor = if_else(lifeExp < mean(lifeExp), "low life_exp", "high life_exp"))

str(gapminder_2007)

#convert new vars to factors
gapminder_2007$gdp_factor <- as.factor(gapminder_2007$gdp_factor)
gapminder_2007$life_exp_factor <- as.factor(gapminder_2007$life_exp_factor)

summary(gapminder_2007)

# Cross tabulate the data
chi_data <- table(gapminder_2007$gdp_factor, gapminder_2007$life_exp_factor)

# Perform Chi-square
life_exp_v_gdp <- chisq.test(chi_data)
