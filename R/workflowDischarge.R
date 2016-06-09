
library(dataRetrieval)
library(dplyr)
library(maps)

source('R/getDischarge.R')

Q <- getDischarge(start="2016-06-4", end="2016-09-06")

site_info <- Q %>% filter(!duplicated(station_nm))

m <- map('state', col='darkgrey', regions=c('florida', 'georgia', 'south carolina', 'north carolina'))
points(x = site_info$dec_long_va, y = site_info$dec_lat_va, pch = 20)


fl1 <- Q[Q$site_no=="02319300",] #get this site's data
plot.new()
t <- plot(x=fl1$dateTime,y=fl1$Flow_Inst, type="l", col="blue", 
          xlab = "Date and Time", ylab = "Discharge (cfs)",lwd=6,cex.lab=1.5,cex.axis=1.25)
title("Withlacoochee River near Madison, FL",line=1)
mtext("Tropical Storm Colin 6/4/2016-6/9/2016")
