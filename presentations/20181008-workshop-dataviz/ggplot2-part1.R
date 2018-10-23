####################R LADIES DATA VIZ WORKSHOP#################
#-------------------------------------------------------------#
#----------------------BASICS OF GGPLOT2----------------------#
#-------------------PART I: GGPLOT GRAMMAR--------------------#
#----------------------by Veronica Frans----------------------#
#-------------------------------------------------------------#
###############################################################

# This is an introduction to ggplot2.
# It is the code that goes along with the R-Ladies East Lansing Workshop presentation
# on October 10, 2018. 
# You can find information on this workshop and can get additional help with R through the R-Ladies Slack channel.
# Please sign up on slack here: 

# ggplot grammar has 3 main components:
  # data
  # aesthetics
  # geometry

# We will see how these components work together to make a ggplot plot.


#---------------------------R SETUP----------------------------#

#ggplot comes from the tidyverse.
#If you don't have it already, it needs to be installed in R.

# install ggplot and the rest of the tidyverse:
  install.packages("tidyverse") #note: you only have to do this once per computer

# load the tidyverse into your workspace:
  library("tidyverse") #note: you have to do this before the beginning of each R session

#------------------------DEMONSTRATION-------------------------#

# examine example dataset called 'iris' which is inherent in R
  head(iris)
  str(iris)
  
# try to create the first layer of the ggplot
  basic_plot <- ggplot() 
  basic_plot    #you will see that it is blank
  
# add data to this first layer
  basic_plot <- ggplot(data=iris)
  basic_plot    #you will see that it is still blank.
  #This is because ggplot still needs to know what part of the data to plot.
  #We need aesthetics, which is the x and the y. 
  
# add a layer of aesthetics
  basic_plot +
    aes(x=Sepal.Length, y=Sepal.Width)
  #This is also blank, but we now have a defined x and y with values in it.
  #Next we need to define the type of plot. This is called the geometry.
  
# example using a scatter plot with 'geom_point'
  basic_plot +
    aes(x=Sepal.Length, y=Sepal.Width) +
    geom_point()
  
# you can also add to the aesthetics that has influence on the geometry
  #change the color and the shape by species
  basic_plot +
    aes(x=Sepal.Length, y=Sepal.Width,
        color=Species, shape=Species) +
    geom_point()
  
# adding additional geometries to your plot
  #example: add a linear regression line for each species
  basic_plot +
    aes(x=Sepal.Length, y=Sepal.Width,
        color=Species, shape=Species) +
    geom_point() +
    geom_smooth(method='lm')
  
# review:
  #Specify the data using 'data=' 
    #ggplot(data = _____) + aes(x=___, y=___) + .
  #or
    #ggplot(data = _____, + aes(x=___, y=___)) + .
  
  #.use '+' sign to add layers:
    
    #(1) geom (type of plotted data)
    #(2) other Fancy stuff!! (stats, labels, facets, themes, etc.)
  

#---------------------------PRACTICE----------------------------#

#short quiz for practice:
  
# -Make a plot called "quiz_1"
# -Use the data set: mpg
# -Make a box plot using "geom_boxplot()"
# -Examine the relationship between "class" and "cty"
  
# (try it and check the answer below!) 
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #-----------------QUIZ ANSWER-----------------#
  head(mpg) #inspect the data
  str(mpg) #inspect the data
  #plot
  quiz_1 <- ggplot(data = mpg) +
                  aes(x = class, y = cty) +
                  geom_boxplot()
  quiz_1
  
  