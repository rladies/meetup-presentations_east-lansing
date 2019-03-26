

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
