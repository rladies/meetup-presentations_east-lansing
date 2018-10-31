library(ggplot2)
library(tidyverse)

head(iris)
str(iris)
as_tibble(iris)


ggplot()
# empty box

ggplot(iris)
# what to plot??

emptyplot <- ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width))
# I have the axes but which kind of plot?
emptyplot + geom_point()

