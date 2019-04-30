#############################################################################
## R-Ladies East Lansing
## Spring Workshop series
## Intro to Statistics w/ R: Part III
## March 18, 2019; 6p
## Hosted by: XX, YY, ZZ
## Offline help: AA, Camille Archer, Janani Ravi, BB
#############################################################################

#####################
## 1.0 Hypothesis testing
#####################


###############################################
# 1.1 Parameteric tests #############################
############################################
## Ch 13: t-test (For normally distributed numerical variables)##########

# Data from W.S. Gosset's 1908 paper on the t-test.
# Two different sleeping drugs were taken by two groups of patients.

# The variable "extra" is the increase in hours of sleep on the groups
# (consisting of 10 patients each).
# The variable "group" gives the labels for which drug each patient took.

# The sleeping data is a built-in data set in R,

## Installing packages
install.packages("ggpubr") # publicationr ready plots w/ ggplot2
install.packages("lsr") # Learning Statistics w/ R by Dani Navarro
# install.packages("tidyverse")
# install.packages("ggplot2") # if you don't have tidyverse installed
install.packages("car")
install.packages("pwr") # basic functions of power analysis

# Loading packages
library(ggpubr)
library(tidyverse) # loads ggplot2, tidyr, dplyr, ...
library(lsr)
library(car)
library(pwr)

# There's no need to explicitly load and attach the sleep dataframe
# 'datasets' package is pre-loaded. So is 'sleep'.
# data(sleep)
# attach(sleep)

#Viewing the data:
View(sleep)
glimpse(sleep)

#Testing Assumptions of T-test
# Assumption1: Equal Variance - Do the spreads seem equal across groups? (i.e. is the variance homogeneous)
ggplot(sleep, aes(x=group, y=extra)) +
  geom_boxplot() +
  theme_minimal()

#Levene’s test checks for homogeneity of variances and the null hypothesis is that all variances are equal. A resulting p-value under 0.05 means that variances are not equal and than further parametric tests such as ANOVA are not suited.
#Note that this test is meant to be used with normally distributed data but can tolerate relatively low deviation from normality.

library(car)
# Levene's test with one independent variable
leveneTest(extra ~ group, data = sleep)



# Assumption2: Normality - Do the data appear normally distributed?
ggplot(sleep, aes(x=extra, color=group, fill=group)) +
  geom_histogram(aes(y=..density..), binwidth = 0.5,
                 position="identity", alpha=0.2) +   # Histogram with density instead of count on y-axis
  geom_density(alpha=0.6) + # adding a density plot
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) + # for outline
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9")) +  # for fill
  labs(title="Sleep histogram plot",x="Extra Sleep (Hrs.)", y = "Density") + # annotating the plot
  theme_classic() # no grey background or grids


#Check by visual inspection: Q-Qplot
#Method1: qqnorm creates a Normal Q-Q plot. You give it a vector of data and R plots the data in sorted order versus quantiles from a standard Normal distribution.
library(ggpubr)
ggqqplot(sleep$extra)

#Method2: There are several methods for normality test such as Kolmogorov-Smirnov (K-S) normality test and Shapiro-Wilk’s test.
#The null hypothesis of these tests is that “sample distribution is normal”. If the test is significant, the distribution is non-normal.
#Shapiro-Wilk’s method is widely recommended for normality test and it provides better power than K-S. It is based on the correlation between the data and the corresponding normal scores.
shapiro.test(sleep$extra)

#Assumption 3: The data are independent -- depends on experimental set up.


##T-tests
# Assuming equal variances (Student's independent t-test):
indpT = t.test(extra ~ group, data = sleep, var.equal=TRUE)

# Not assuming equal variances (Welsh's independent t-test, r default is that variances are unequal between groups):
indpT_var = t.test(extra ~ group, data = sleep)

# Paired Test
pairedT = t.test(extra ~ group, data = sleep, paired = TRUE)


# Extracting key information
# Tip: name your variables using underscores rather than hyphens; hyphens are considered to be 'minuses'
t_statistic <- indpT$statistic
p_val <- indpT$p.value
ci95 <- indpT$conf.int
df <- indpT$parameter


## Effect Size: How significant is significant?
# Compute the Cohen's d or Hedges'g effect size statistics.
# cohensD( x = NULL, y = NULL, data = NULL, method = c("pooled","raw", "corrected", "paired", "x.sd", "y.sd"), mu = 0, formula = NULL )
library(lsr)
effect_size = cohensD(extra ~ group, data = sleep)

## Quantification of the effect size magnitude is performed using the thresholds define in Cohen (1992). The magnitude is assessed using the thresholds provided in (Cohen 1992), i.e. |d|<0.2 "negligible", |d|<0.5 "small", |d|<0.8 "medium", otherwise "large"
#More examples: https://rdrr.io/cran/lsr/man/cohensD.html
#Hodge's g vs. cohen's d:  https://stats.stackexchange.com/questions/1850/difference-between-cohens-d-and-hedges-g-for-effect-size-metrics

## Power Analysis
#Power is the probability of rejecting the null hypothesis when the specific alternative hypothesis is true.
#That is your ability to find a difference when a real difference exists. The power of a study is determined by three factors: the sample size, the alpha level, and the effect size.
library(pwr)
#pwr.t.test(n = length(sleep$extra)/2, d = , sig.level = 0.05 , power = 0.8, type = c("two.sample", "one.sample", "paired"))

#calculate the necessary sample size for a specified power
s.d= sd(sleep$extra)
pwr.t.test(d = effect_size, sig.level = 0.05 , power = 0.8, type = "two.sample", alternative = "two.sided")
# where n is the sample size, d is the effect size, and type indicates a two-sample t-test, one-sample t-test or paired t-test.

# calculate the power when given a specific sample size
len = length(sleep$extra)/2
pwr.t.test(n= len, d = effect_size, sig.level = 0.05,
           type = "two.sample", alternative = "two.sided")

#If you have unequal sample sizes, use the following, where n1 and n2 are the sample sizes
pwr.t2n.test(n1 = , n2= , d = , sig.level = , power = )


#Reference
#[1] http://people.stat.sc.edu/Hitchcock/R_sleeping.txt
#[2] http://www.cookbook-r.com/Statistical_analysis/t-test/
#[3] https://rpubs.com/tmcurley/ttests




## Ch 12: chi-square (For Nominal Variables)###########

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

#convert new variables to factors
gapminder_2007$gdp_factor <- as.factor(gapminder_2007$gdp_factor)
gapminder_2007$life_exp_factor <- as.factor(gapminder_2007$life_exp_factor)

summary(gapminder_2007)

# Cross-tabulate the data
cont_tbl <- table(gapminder_2007$gdp_factor, gapminder_2007$life_exp_factor)

#Assumptions of Chi-square test

#Expected frequencies are sufficiently large. Generally would like to see all your expected frequencies larger than about 5, though for larger tables
#you would probably be okay if at least 80% of the the expected frequencies are above 5 and none of them are below 1.
#Data are independent of one another.

# Performing Chi-square test for independence
# Is there some relationship between the rows and columns of this table?
#In R we can perform this test with the chisq.test function
#If you input a cross-tabulation rather than a simple frequency table, it realises that you’re asking for a test of independence and not a goodness of fit test.
# if you want to change the null hypothesis, just specify the probabilities using the p argument: Ex. chisq.test(observed_frequencies, p = c(0.4, 0.2, 0.2))

life_exp_v_gdp <- chisq.test(cont_tbl)


#Yates correction/continutity correction: Specifically, when N is small and when df= 1, the goodness of fit statistic tends to be “too big”, meaning that you actually have a bigger value than you think (or, equivalently, the p values are a bit too small). Basically this correction subtracts 0.5 from everywhere.

#library(lsr)
#associationTest(~ gdp_factor + life_exp_factor, gapminder_2007)


# Performing Fisher's test (for small sample sizes)
#If cell sizes are too small, but you’d still like to test the null hypothesis that the two variables are independent?
#This test doesn't have a test statistic. It calculates the p-value directly.
# The probability of the observed frequencies occurring are calculated given that fixed row and column totals.
#To calculate the p-value we calculate the probability of observing this particular table or a table that is “more extreme”.

fisher.test(cont_tbl)

# McNear's Test
#If you suspect that data are not indpendent, use this test or Cochran's test.
#Ex. A before and after study of attitudes
#this is a standard repeated measures design, and none of the tests we’ve considered so far can handle it.
# The trick here is to rewrite the data so that each participant appears in only one cell, thus satisfying the indpendence assumption.
#Thus, the null hypothesis in McNemar’s test is that we have “marginal homogeneity”.
# Are the row totals different from the column totals?

mcnemar.test()


#Effect Size: How significant is significant?
#cramersV() takes a contingency table as input, and prints out the measure of effect size
# this statistic, you just divide the X^2 value by a factor (k-1) of the sample size, and take the square root. Where k= min(nrows, ncols)
##Cohen indicates that the effect size index (w)	<0.10 = small	<0.30 = medium	> 0.50 = large

library(lsr)
cramersV(cont_tbl)

# Power Analysis
# Most of the time when a researcher is concerned about issues regarding power it is when a study if first being proposed prior to collection of any data. 
#In this situation, the investigator wants to determine what an appropriate sample size would be or justify a proposed sample size. In order to answer this question, the researcher needs to know the other two parts of the equation: alpha level and effect size. 


#############
## References
#############
# 1. Learning Statistics w/ R by Dani Navarro: https://learningstatisticswithr.com/book
# 2. http://meera.snre.umich.edu/power-analysis-statistical-significance-effect-size
# 3. http://www.biostathandbook.com/multiplecomparisons.html

###############################################
# 1.2 Non-parameteric tests #############################
############################################
# generate some sample normal distributions
sample_data_1<-rnorm(200)
hist(sample_data_1)
sample_data_2<-rnorm(200)
hist(sample_data_2)

sample_data_3<-sample(x = 1:10000, size = 200)
hist(sample_data_3)
sample_data_4<-sample(x = 1:10000, size = 200)
hist(sample_data_4)


## (Ch 13) Wilcoxon (For distributed-free variables)
wilcox.test(sample_data_3,sample_data_4)


## Mann-Whitney###########################

#Non-parametric mann Kendall Trend test.
#(If there is a monotonic upward or downward trend of the variable of interest over time.)
#The tend may or may not be linear.

#Null hypothesis: No monotonic trend
#only shows the direction of the trend, not magnitude.

#Values:
# A list with class Kendall.
# tau: Kendall's tau statistic
# sl: two-sided p-value
# S: Kendall Score
# D: Denominator, tau=S/D
# varS: variance of S

#install.packages(kendall)
library(Kendall)
library(boot)
data(GuelphP)  #Amount phospherous (p) is a river.
plot(GuelphP)
#replace missing values in the series with estimates
missingEst<-c(0.1524, 0.2144, 0.3064, 0.1342)  # define the missing values to be filled in the time series.
GuelphP2<-GuelphP  # copy data to a new dataset to keep the original data
GuelphP2[is.na(GuelphP)]<-missingEst  # replacing missing values with the estimates
plot(GuelphP2)

mann_Gue<- MannKendall(GuelphP2)  # run Mann Kendall test on the corrected dataset.
summary(mann_Gue)


# Another example

# The autocorrelation in this data does not appear significant.
# The Mann-Kendall trend test confirms the upward trend.
data(PrecipGL)   # data: Annual precipitation entire Great Lakes
plot(PrecipGL)    #plot the data

# The time series plot with lowess smooth suggests an upward trend
# "time" creates the vector of times at which a time series was sampled.
lines(lowess(time(PrecipGL),PrecipGL),lwd=3, col=2)  #locally-weighted polynomial regression

m_test<- MannKendall(PrecipGL) #run Mann Kendall test
summary(m_test)
print(m_test)
tau_m<- m_test$tau
print(tau_m)
var_m<- m_test$varS
print(var_m)
Pval_m<- m_test$sl
print(Pval_m)

#Computes Sen's slope for linear rate of change and corresponding confidence intervalls
# calculate calculate a robust estimate of the slope of the trend.
#install.packages(trend)
library(trend)
sens.slope(PrecipGL, conf.level = 0.95)



# Reference:
#https://cran.r-project.org/web/packages/Kendall/Kendall.pdf
#https://cran.r-project.org/web/packages/trend/trend.pdf




