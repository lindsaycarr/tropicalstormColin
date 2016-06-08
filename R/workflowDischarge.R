
library(dataRetrieval)
library(dplyr)
library(maps)

source('R/getDischarge.R')

Q <- getDischarge()

site_info <- Q %>% filter(!duplicated(station_nm))

m <- map('state', col='darkgrey', regions=c('florida', 'georgia', 'south carolina', 'north carolina'))
points(x = site_info$dec_long_va, y = site_info$dec_lat_va, pch = 20)
