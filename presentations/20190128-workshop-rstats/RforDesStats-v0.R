#Before starting, let's install any necessary packages that we'll be using.
#You should have these already installed from previous workshops.
install.packages("gapminder")
install.packages("psych")
install.packages("vioplot")


#Then, we'll load them into our R workspace.
library(tidyverse)
library(purrr)
library(psych)
library(vioplot)
library(ggplot2)
library('gapminder')

#First things first, look at raw data structure. 
#Knowing how your data look overall will help you analzye and organize it.
#Using base r funciton "str" shows dataype and unique values.
str(gapminder)
#Compared to tidyverse function "glimpse" shows datatype and lists first few rows.
glimpse(gapminder)
#We can also look at the first 10 and last 10 rows.
head(gapminder)
tail(gapminder)
#"View" will open the dataset in a new tab.
View(gapminder)
#If you ever need a reminder of your column names and order, 
##use the function "colnames".
colnames(gapminder)


#Start by checking for missing data using the summary function.
summary(gapminder)
#if there are missing data points, you will see them in the bottom row, 
#but only for the variable that is missing data.

#And we can compare this to 'psych' package.
describe(gapminder)


#"attach" 
attach(gapminder)

#Plot a histogram to look at the distribution of you data.
hist(lifeExp)

#Here, we use the summary" function again, but this time for a variable, not a dataset.
#This gives us the a table of basic stats including minimum, median, quartiles, and min/max.
summary(lifeExp)

#Use any of these to recall a single descriptor.
max(lifeExp)
min(lifeExp)
range(lifeExp)
median(lifeExp)
mode(lifeExp)
mean(lifeExp)
quantile(lifeExp)


#calculate the mean of selected samples
mean(lifeExp[1:10])
#we can select the rows the are from Bulgaria
median(lifeExp[1:10])
#mode does not work for the small data set because no number appears twice
mode(lifeExp[1:10])


#There are many ways to get summary statistics by grouping. 
#For example, if we wanted to get summary statistics of lifeExp by continent:

##using base R:
tapply(lifeExp, continent, summary) 

#using dplyr:STILL AN ERROR, doesn't work
##Note how we used 'na.rm=TRUE' to remove missing data (if needed).
gapminder %>% 
  group_by(continent) %>% 
  summarize(mean=mean(lifeExp, na.rm=TRUE),
            median=median(lifeExp))

#using purrr:
gapminder %>% split(.$continent) %>% map(summary)

#using psych
describeBy(lifeExp, continent, mat = TRUE) 

#In short, there are many ways to get the same information, so play around!

#What if we want to save the table as a file?
getwd()
setwd("C:/Users/Miranda Haus/Documents/RLadies_Workshops")
write.csv(describeBy(lifeExp, continent, mat = TRUE), "test.csv")
#alterantively, you can make a new observation and write it instead.
test2<-describeBy(lifeExp, continent, mat = TRUE)
write.csv(test2, "test2.csv")


#You may or may not want to see residuals based on your experience/field/etc.
qqnorm(lifeExp)
qqline(lifeExp)

#Let's graph these descriptive statistics so they are interpretable by our readers (e.g. boss, reviewer, etc.)
#Making boxlots.
#Using base R:
boxplot(lifeExp)
  #Or look at boxplots across group
  boxplot(lifeExp~continent)
  boxplot(lifeExp~continent, xlab="Continent", ylab="Life Expectancy (Years)")
  #You can add notches to 
  boxplot(lifeExp~continent, notch=T, xlab="Continent", ylab="Life Expectancy (Years)")
  
#Now that we know what's common in our data set, let's look at what is uncommon or weird.
#outliers
outlier_values_lifeExp <- boxplot.stats(lifeExp)$out  # outlier values.
outlier_values_lifeExp

#Well... lifeExp doesn't have any outliers.  So let's look at a variable that does:
outlier_values_pop <- boxplot.stats(pop)$out
outlier_values_pop
#Great! But how can I go back to my dataset to find these outliers specifically?
#Let's create a subset of the data that includes only observations above our minimum outlier.
min(outlier_values_pop)
out.set <-filter(gapminder, pop >= '45598081')
View(out.set)


##overlapping data points
  #use the 'ggplot2' package
  qplot( x=continent , y=lifeExp , geom=c("boxplot","jitter"))
  
  #In this instance, individual data point block the view for a lot of the stats we're interested in.
  #This is called "overplotting."
  #So let's look at another way to plot our data, while still highlighting the distribution of the data.


#Violin plots are more descriptive wasy to visulaize box plots.
#They overlap distrbution and key statistics (e.g. mean, quartiles, etc.)
#This uses the 'vioplot' package.
vioplot(lifeExp)
vioplot(lifeExp~continent)
#using psych
violinBy(lifeExp)

#using ggplot2
ggplot(gapminder, aes(factor(continent), lifeExp)) +
  geom_violin(aes(fill = factor(continent)))
  #The plot is missing relevant data. 
### Will fill in with overlapping boxplots, or may challenge attendees to do this???


#What if we want to look at how two variables interact?
#using base R
plot(pop,lifeExp)
cor(pop,lifeExp)

#using ggplot2
#even with attach, we must still include dataset
ggplot(gapminder, aes(x=pop, y=lifeExp))+ geom_point()

#using 'psych'
#note the order of variable changes to get the same plot
pairs.panels(gapminder)
#Using 'psych' we can plot histograms on scatterplots.
scatter.hist(lifeExp, pop)