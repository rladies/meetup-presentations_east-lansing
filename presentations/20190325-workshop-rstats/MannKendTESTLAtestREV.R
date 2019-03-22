
library(mice)
library(Kendall)
library(modifiedmk)
library(trend)
library(sp)
library(statsr)
library(statsDK)
library(Hmisc)
library(rkt)
library(urca)

setwd("//Desktop")



## https://www.youtube.com/watch?v=DnIsNxPKtUM

Greenwich<-read.csv("FINALREV.csv", header=TRUE)

##Greenwich <- readLines("FINALMMK.csv")
Greenwich

##Made into a vector to run the Modified Mann endall (MK2 = mmkh(ab))
ab <- c(Greenwich$NDVI)
ab

spear(ab)




##Mousey<- mice(Greenwich)

##Greenwich<-complete(Mousey)

Greenwich[1:138,]


ex<-rkt(Greenwich$NDVI,Greenwich$NDVI) ## uses the RKT 

ex

TX<-ts(Greenwich$NDVI, frequency = 12, start = c(2006, 11,1), end =c(2017,4,23))

TX

dim(TX)




plot(TX)

##TS <-ts(Greenwich$NDVI,
  ##      frequency=6,
    ##    start=c(2005,11))


##Also look at a time series ANOVA as the classic ANOVA will not work

plot(stl(TX, 
         s.window="periodic"))

MK = MannKendall(TX)

summary(MK)

SMK <- SeasonalMannKendall(TX)

summary(SMK)

sens.slope(TX)

mmkh(ab) ## modified Mann Kendall  sort of worked



##Run the ADF test

MCX<-(Greenwich$NDVI)

attach(Greenwich)

x<-ur.df(NDVI, type = "trend", selectlags ="AIC") #I use the AIC criteria

x

summary(x)

x@cval #criteria values

x@lags #lags included

x@teststat

b=x@teststat[1]
b








