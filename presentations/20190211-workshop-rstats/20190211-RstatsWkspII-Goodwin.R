#######################################
######### Workshop PART II ############
#######################################
## *RStats Workshop: Part II*
# - Probability distributions, skewness & kurtosis, basic transformations w/ plots
# - Basic Parametric (e.g., t.test, ANOVA) & Non-parametric statistical tests
# - Inferential Statistics: hypothesis testing, p-value, correlations, confidence intervals
# - During workshop, Sarah will highlight differences among Excel/SPSS vs R


#### Installing packages if needed ####
#install.packages("tidyverse")
#install.packages("psych")

#### Loading packages ####
library(tidyverse) # package to work with tidy data & visualization
# OR: load the individual packages:
#library(readr)    # part of tidyverse
#library(tidyr)    # part of tidyverse
#library(dplyr)    # part of tidyverse
#library(ggplot2)  # part of tidyverse
#library(purrr)    # part of tidyverse

library(readxl)    # to read Excel files
library(psych)     # has a few useful statistical functions


############
## about me
############
# Sarah Goodwin
# Ph.D. Applied Linguistics, Georgia State University, 2017
# postdoctoral researcher, Early Language and Literacy Investigations Laboratory (Human Development and Family Studies)
# goodwi27@msu.edu
## I am an "intermediate ability level" R user ##

### Great book for me (though examples may not be relevant to your discipline or your work): Stefan Gries' "Statistics for Linguistics with R"
# http://www.degruyter.com/view/product/203826



## Own Dataset?
# if you want to use your own dataset, it is best if it is plaintext. It should have just one row with all of your column/variable names, then all of your data.  Qualtrics, for instance, gives you a download with three rows at the top before the data are presented, so I always have to remove rows 2 and 3.

## Migrating from Excel?
# if you're using Excel, I find it easier to save my file in CSV format instead (File > Save As -- or press F12 -- then under "Save As Type" in the drop-down, change that to "CSV UTF-8 Comma Delimited (CSV)")
here::here() ## Points to wherever you opened your RStudio session.
# Path would be relative to your starting point/location of your R file.

name_of_your_dataset <- read_csv("path/to/your/file", # select a file from your system
                                 col_names=TRUE,      # column headings are in row 1
                                 na=c("N/A","NA","None","")) # tell R if you have

# name_of_your_dataset <- read.csv("path/to/your/file", # select a file from your system
#                                  fileEncoding="UTF-8-BOM", # help you deal with special characters
#                                  header=TRUE, # column headings are in row 1
#                                  sep=",", # data are comma separated
#                                  na.strings=c("N/A","NA","None","")) # tell R if you have any notation that indicates missing data; R puts gray-text NA by default in the Viewer


###############
## Gapminder ##
###############
# load and examine Gapminder dataset
# this isn't typical, though. Most packages don't have example datasets.
# Tidyverse & Gapminder have sample datasets.

library(gapminder) # Gapminder data: life expectancy, GDP per capita, population by country

str(gapminder) # examine structure of R object
glimpse(gapminder) # ...
summary(gapminder) # very basic column-wise stats

###################
## DISTRIBUTIONS ##
###################
# psych::describe() # works without loading
describe(gapminder$lifeExp) # see stats at a glance, requires 'psych' R package
description <- describe(gapminder) # saves describe as object called 'description'
description$min # to look at a specific measure across variables

# hist(gapminder$lifeExp) # histogram
ggplot(gapminder, aes(x=lifeExp)) +
  geom_histogram() +
  theme_bw()

description$skew        # Skewness: left/right trend of distribution curve
description$kurtosis    # Kurtosis: peakedness/flatness of distribution curve

## Other ways to compute skewness and kurtosis
# skew(gapminder$lifeExp) # skewness value for Life Expectancy
# kurtosi(gapminder$lifeExp) # kurtosis value for Life Expectancy

#####################
## TRANSFORMATIONS ##
#####################

# You may want to rescale data if the tests you want to use assume normally-distributed data or you have different measures along very different scales. See below for "Testing for Normality"

## Log transformation
gapminder$log.pop <- log(gapminder$pop, base=10)
logpop_hist <- ggplot(gapminder, aes(x=log.pop)) +
  geom_histogram() +
  # geom_density() +
  theme_bw()
logpop_hist
pop_hist + scale_x_log10()

# log is BASE E by default, NOT BASE 10

showinglogtransformation <- log10(gapminder$pop)
describe(showinglogtransformation)
hist(showinglogtransformation)

## Rescaling variables
View(gapminder)

GDP_rescaled <- scale(gapminder$gdpPercap) # 'scale' available in base R; transform your data to z-scores
View(GDP_rescaled)

## Rescaling w/ Psych package
#library(psych) #load if needed
poprescaled <- rescale(gapminder$pop,m=50,sd=15) # rescale specifying a certain mean and standard deviation
View(poprescaled)
describe(poprescaled)


#### Testing for normality ####
## Is your data normally distributed?
## Checking normality, goodness of fit, independence/difference tests

gapminder %>%
  ggplot(aes(x = lifeExp)) +
  geom_density() +
  stat_function(fun = dnorm,
                args = list(mean = mean(gapminder$lifeExp),
                            sd = sd(gapminder$lifeExp)),
                color = "red")

## viewing the distribution
pop_hist <- ggplot(gapminder, aes(x=pop)) +
  geom_histogram() +
  # geom_density() +
  theme_bw() # no grey background
pop_hist

## Shapiro-Wilk test
shapiro.test(gapminder$lifeExp) # gapminder Life Expectancy is nonnormally distributed.  p > .05 would indicate null hyp cannot be rejected and data are normally distributed.
# significant --> non-normal

## Kolmogorov-Smirnov test
ks.test(gapminder$lifeExp,
        "pnorm",                       # what you are testing for
        mean=mean(gapminder$lifeExp),  #
        sd=sd(gapminder$lifeExp))      # Kolmogorov-Smirnov test needs three additional arguments: the distribution to test against (pnorm), the M, and the SD
# significant --> non-normal
# you may get an error from R for the ks.test that says "ties should not be present"; it does not like multiple hits of the same number
# KS vs Shapiro: https://stats.stackexchange.com/questions/362/what-is-the-difference-between-the-shapiro-wilk-test-of-normality-and-the-kolmog

# for data that are ordinal, are nonnormal, or have outliers
median(gapminder$lifeExp)

# most useful only for normally-distributed data
mean(gapminder$lifeExp)

pop_hist +
  geom_vline(xintercept=mean(gapminder$pop), color="red") +
  geom_vline(xintercept=median(gapminder$pop), color="blue") +
  scale_x_log10()

sd(gapminder$lifeExp)
var(gapminder$lifeExp) # variance (=sd^2)

#SD vs SE
# https://www.r-bloggers.com/standard-deviation-vs-standard-error/
# here, instead of gapminder, we're using sample sets of numbers we're calling R objects "a" and "b"
a <- c(-0.73,-0.3,0.01,0.25,0.59) # sample test scores (0 being average probability of examinee success)
b <- c(-0.3,-0.13,-0.02,0.19,0.41) # sample standard errors
mypretenddata <- as.data.frame(cbind(a, b)) # bind a and b together, each in their own column - as a data frame
View(mypretenddata)

#Plotting line/bar plot with the standard error added
mypretenddata_2 <- barplot(mypretenddata$a,ylim=c(-1.5,1.5))
arrows(x0=mypretenddata_2,y0=mypretenddata$a+mypretenddata$b,y1=mypretenddata$a-mypretenddata$b,angle=90,code=3,length=0.25)


# plot to show confidence intervals around the mean (may not be so useful)
# err <- error.dots(gapminder$lifeExp)
# err$des   # ...
# err$order # rank ordered?


################################
## Correlation/Association tests
################################

## for post-hoc tests, see the leveneTest command in the 'car' package.
# leveneTest(DV ~ IV, data = name_of_your_dataset_here)
## Or see Dani Navarro's "R for Psychological Science" 20.4.1
# http://psyr.org/introductory-statistics.html


### for effect sizes, check out 'compute.es' package
install.packages('compute.es') # one-time
library(compute.es)
?`compute.es-package`

# correlations - Pearson is default
cor(gapminder$lifeExp,gapminder$pop)

cor(gapminder$lifeExp,gapminder$pop,
    method="spearman") # to change the method

# if you have incomplete data, you'll need to add the "use" argument to cor to specify to R whether to correlate pairwise, use only complete observations, remove NAs, or another stipulation.


## more detailed correlations (needs 'psych' package)
corr.test(gapminder$lifeExp,gapminder$pop)


## Correlation & confidence intervals
print(corr.test(gapminder$lifeExp,gapminder$pop),
      short=FALSE) #corr.test requires 'psych' package




## We may touch on chi-sq, t-tests, ANOVAs if time permits





# so we have simplified data to compare for statistical tests:

# sample 'n' rows from gapminder data
#library(dplyr) #load package if needed
abbrevdata_1 <- sample_n(gapminder,size=20)
abbrevdata_2 <- sample_n(gapminder,size=20)

# or sample specific records (requires 'dplyr')
View(gapminder)
abbrevdata_1 <- gapminder %>%
  filter(year == "1982")  #rows with data from the year 1982
abbrevdata_2 <- gapminder %>%
  filter(year == "1987")  #rows with data from the year 1987

data_shortened <- table(abbrevdata_1$lifeExp,abbrevdata_2$lifeExp)


## chi-square statistical test
test <- chisq.test(data_shortened, correct=FALSE); test
test$residuals
sqrt(test$statistic/sum(data_shortened)*(min(dim(data_shortened))-1)) # effect size: Cramer's V
test$expected



## t-test
t.test(data_shortened, mu=0) # if normality had not been violated, we would use this line. Assumes UNequal variances by default (can add var.equal=TRUE to specify equal variances)


# instead, use Wilcoxon:
wilcox.test(data_shortened, mu=0, correct=FALSE)


#### ANOVA ???
model_aov <- aov(lifeExp ~ continent, data=gapminder)
broom::tidy(model_aov)
#aov(DV ~ IV, data=dataset)
#model.01<-aov(DV ~ IV, data=dataset); summary(model.01)
model_tukey <- TukeyHSD(model_aov)
broom::tidy(model_tukey)

# Kruskal-Wallis
#kruskal.test(DV ~ IV, data=dataset)
?stats::kruskal.test



##linear regression with 1 predictor, sum contrasts (best for the sake of comparability with other software)
options(contrasts=c("contr.sum", "contr.poly")) # set sum contrasts
#model.01 <- lm(DV ~ IV, data=dataset)

#summary(model.01) # determine the nature of the effect(s) numerically

#drop1(model.01, test="F") # for p values ; with multiple variables, tells you which predictor can be dropped

#NOTE CASE of Anova different from anova
#Anova(model.01, type="III") # compute ANOVA of model with type III sums of squares. Same as SPSS. In 'car' library





##  power analyses
#install.packages('pwr') #if needed
library(pwr)

#for instructions CORRELATIONS
help(pwr.r.test)

#for correlation power posteriori
pwr.r.test(n=--, # n = number of participants
           r=.58,
           sig.level=.05,
           alternative=c("two.sided"))
#for correlation power a priori. How big of an N do you need? [we want a medium effect size (.30)]
pwr.r.test(r = .30, sig.level = 0.05, power = .80)
#for correlation power a priori. How big of an N do you need for one-tailed?
pwr.r.test(r = .30, sig.level = 0.05, power = .80, alternative = c("greater"))

#for instructions ANOVA
help(pwr.anova.test)

#for posteriori
pwr.anova.test(k = 4, n = 10, f = .432, sig.level = 0.05)
#for a priori
pwr.anova.test(k = 4, f = .4, sig.level = 0.05, power = .80)

#for instructions t-test
help(pwr.t.test)

#for posteriori
pwr.t.test(n=10, d=1.93, type=c("two.sample"))

