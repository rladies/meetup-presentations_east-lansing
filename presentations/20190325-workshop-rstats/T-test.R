#T-test

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

# Do the spreads seem equal across groups? -- We'll address verifying our intuition later.
ggplot(sleep, aes(x=group, y=extra)) +
  geom_boxplot() +
  theme_minimal()


# Do the data appear normally distributed?
ggplot(sleep, aes(x=extra, color=group, fill=group)) +
  geom_histogram(aes(y=..density..), binwidth = 0.5,
                 position="identity", alpha=0.2) +   # Histogram with density instead of count on y-axis
  geom_density(alpha=0.6) + # adding a density plot
#  geom_vline(data=mu, aes(xintercept=grp.mean, color=group),
 #            linetype="dashed")+
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) + # for outline
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9")) +  # for fill
  labs(title="Sleep histogram plot",x="Extra Sleep (Hrs.)", y = "Density") + # annotating the plot
  theme_classic() # no grey background or grids

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
ci_95 <- indpT$conf.int
df <- indpT$parameter


## Effect Size: How significant is significant?
# Compute the Cohen's d or Hedges'g effect size statistics.
# cohensD( x = NULL, y = NULL, data = NULL, method = c("pooled","raw", "corrected", "paired", "x.sd", "y.sd"), mu = 0, formula = NULL )
library(lsr)
effect_size = cohensD(extra ~ group, data = sleep)

## Quantification of the effect size magnitude is performed using the thresholds define in Cohen (1992).
#The magnitude is assessed using the thresholds provided in (Cohen 1992), i.e. |d|<0.2 "negligible", |d|<0.5 "small", |d|<0.8 "medium", otherwise "large"
#More examples: https://rdrr.io/cran/lsr/man/cohensD.html
#Hodge's g vs. cohen's d:  https://stats.stackexchange.com/questions/1850/difference-between-cohens-d-and-hedges-g-for-effect-size-metrics

## Power Analysis
#Power is the probability of rejecting the null hypothesis when the specific alternative hypothesis is true.
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




#Testing Assumptions of T-test
#Normality
#Check by visual inspection: Q-Qplot
#qqnorm creates a Normal Q-Q plot. You give it a vector of data and R plots the data in sorted order versus quantiles from a standard Normal distribution.
library(ggpubr)
ggqqplot(sleep$extra)


#There are several methods for normality test such as Kolmogorov-Smirnov (K-S) normality test and Shapiro-Wilk’s test.
#The null hypothesis of these tests is that “sample distribution is normal”. If the test is significant, the distribution is non-normal.
#Shapiro-Wilk’s method is widely recommended for normality test and it provides better power than K-S. It is based on the correlation between the data and the corresponding normal scores.
shapiro.test(sleep$extra)

#Equal Variance
#Levene’s test checks for homogeneity of variances and the null hypothesis is that all variances are equal.
#A resulting p-value under 0.05 means that variances are not equal and than further parametric tests such as ANOVA are not suited.
#Note that this test is meant to be used with normally distributed data but can tolerate relatively low deviation from normality.


library(car)
# Levene's test with one independent variable
leveneTest(extra ~ group, data = sleep)

# Levene's test with multiple independent variables
#leveneTest(len ~ extra*group, data = sleep)


#Reference
#[1] http://people.stat.sc.edu/Hitchcock/R_sleeping.txt
#[2] http://www.cookbook-r.com/Statistical_analysis/t-test/
#[3] https://rpubs.com/tmcurley/ttests
