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
## Briefly describe the concept of a Hypothesis test.
## p-value and stuff...

## The following are examples of hypothesis testing in practice.
## Parametric (t) & Non-parametric statistical tests (Wilcox) (20min)


library(gapminder) #load gapminder package (contains built-in dataset of world populations, life expectancy, and GDP)
library(dplyr) #load dplyr (part of 'tidyverse', useful for data manipulation)
summary(gapminder$lifeExp)
gapminder %>%
  group_by(continent) %>%
  summarize(lifeExp = mean(lifeExp))
lifeExpAfrica<-filter(gapminder, continent == "Africa")
lifeExpAsia<-filter(gapminder, continent == "Asia")


# generate some sample normal distributions
sample_data_1<-rnorm(200)
hist(sample_data_1)
sample_data_2<-rnorm(200)
hist(sample_data_2)

sample_data_3<-sample(x = 1:10000, size = 200)
hist(sample_data_3)
sample_data_4<-sample(x = 1:10000, size = 200)
hist(sample_data_4)


## 1.1 Parameteric tests ##
## Ch 12: chi-square (For Nominal Variables)
chisq.test()

## Ch 13: t-test (For normally distributed numerical variables)

t.test(sample_data_1,sample_data_2) # assumes unequal variances by default

## 1.2 Non-parameteric tests ##
## (Ch 13) Wilcoxon (For distributed-free variables)
wilcox.test(sample_data_3,sample_data_4)

## Mann-Whitney

## Sp. example: Non-parametric Mann Kendall trend test for time-series


#Values:
# A list with class Kendall.
# tau: Kendall's tau statistic
# sl: two-sided p-value
# S: Kendall Score
# D: Denominator, tau=S/D
# varS: variance of S


library(Kendall)
library(boot)
data(PrecipGL)
data(GuelphP)
plot(GuelphP)
#replace missing values in the series with estimates
missingEst<-c(0.1524, 0.2144, 0.3064, 0.1342)
GuelphP2<-GuelphP
GuelphP2[is.na(GuelphP)]<-missingEst
plot(GuelphP2)

mann_Gue<- MannKendall(GuelphP2)
summary(mann_Gue)

# Annual precipitation entire Great Lakes
# The time series plot with lowess smooth suggests an upward trend
# The autocorrelation in this data does not appear significant.
# The Mann-Kendall trend test confirms the upward trend.
data(PrecipGL)  #Annual precipitaiton,  1900-1986, Entire Great Lakes
plot(PrecipGL)
lines(lowess(time(PrecipGL),PrecipGL),lwd=3, col=2)  #locally-weighted polynomial regression
acf(PrecipGL)  #autocorrelation function
m<- MannKendall(PrecipGL)
summary(m)
print(m)
m$tau
m$varS
m$sl

#Computes Sen's slope for linear rate of change and corresponding confidence intervalls
library(trend)
sens.slope(PrecipGL, conf.level = 0.95)



# Reference:
#https://cran.r-project.org/web/packages/Kendall/Kendall.pdf
#https://cran.r-project.org/web/packages/trend/trend.pdf




## Test selection: Plot/Graphic of how to select the appropriate test for your data?



## For each test above cover the following using the gapminder (or other) dataset.
## I encourage you to google for an example of your test performed with the gapminder dataset.
## There are lots of pre-made examples out there.

## Reading in Data i.e. what format does the data need to be in to begin the analysis?
## Show **simple** example and point to resource to see other formats.


## When do I use this test?
## (Ex. type of data (nominal v. numerical; discrete v. continuous and assumptions of data)
## Assumptions can include: normality, linearity, independence, homogeneity of variance (or homoescedasticity)etc.


## How do I test these assumptions?
## (For this session, I suggest we do not delve into data transformations, if possible)




## Run the test (identify widely-used basic modifications to arguments/parameters that result in different versions of the test).
## **No need to demonstrate all the different parameters, you can do one type and have students do another type to show that the result is different.**

## Identify key outputs needed to form conclusions from the test.
## ex. statistic, p-value, confidence interval.

## Show how to extract and display key statistics using $


## Indicate the conclusion from the test.


##################
## 2.0 Effect Size
##################
## How significant is significant?
###If the conclusion is that the difference is statistically significant, this does not that difference is important or meaningful.
## Effect size is a standardized way of reporting difference between the control and experimental groups. Generally, Effect size = diff(mu1-mu2)/sd of one of the groups.
## How to interpret effect size? Cohen's d is a general guide: <0.1 = trivial effect; 01-0.3 = small effect; 0.3-0.5= moderate effect; >0.5 = large difference effect.

## How to do you compute effect size? p-value intro.


## [If time permits] False Discovery Rate (FDR)
## What is the chance that we reach a wrong conclusion? How can we reduce the number of false positives?
## This consideration becomes important in cases where you are doing multiple comparisons
## Bonferroni correction Vs. Benhamini-Hochberg procedure (where individual tests are assumed to be independent of each other, i.e you're comparing Sample A vs. Sample B, and Sample C vs. Sample D etc.);
## Tukey-Kramer vs. (where individual tests can be dependent, i.e. you're comparing Sample A vs. Sample B, and Sample A vs. Sample C etc.) -- One example of this is when doing ANOVA



## Compare your test with alternative tests (if simple). Ex. Fisher's exact test (for small data) vs. Chi-Square for data >1000. *** Keep it Simple*** If you know more, leave the complicated things for the question and answer period or just point to another resource.

##################
## Visualizations!
##################
## [If Time permits] Visualize/Graphing the results from the (main) test

## Run a **Simple** Power Analysis for this test. Identify key inputs and outputs needed to form conclusion. State conclusion.
## Power refers to the probability that your test will find a statistically significant difference which this difference actually exists. To perform any power test you will need to know (inputs) the following: type of test, significance level (alpha), estimated effect size (common practice is to use 0.5) and your expected sample size. When these values are entered a power value (output) between 0 and 1 will be generated. For power< 0.8, increase your sample size.



#############################################################
## I think I've incorporated these items in the above outline
#############################################################
# Ch 11: Begin with Hypothesis testing (Navarro Ch 11)?
# Or mention p-values, effect sizes, etc. within each test? (15min)

# Corrected p-values - Janani’s code :-) (p.adjust(): Bonferroni vs BH)

# FDR

# Ch 11.8: Review Power tests -- show R code lines, briefly mention why needed (but if people have specific questions for their study, they may have to figure that out for themselves) (15min)

# Exercise w/ Gapminder (15min)


#############
## References
#############
# 1. Learning Statistics w/ R by Dani Navarro: https://learningstatisticswithr.com/book
# 2. http://meera.snre.umich.edu/power-analysis-statistical-significance-effect-size
# 3. http://www.biostathandbook.com/multiplecomparisons.html