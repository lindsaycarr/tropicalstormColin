# merge precip + streamflow data
library(dplyr)
library(tidyr)
library(geoknife) #order matters because 'query' is masked by a function in dplyr
library(RColorBrewer)
library(maps)

source('R/getPrecip.R')
source('R/visualizePrecip.R')

statesTSColin <- c('FL', 'AL', 'GA', 'SC', 'NC')
startTSColin <- "2016-06-06 05:00:00"
endTSColin <- "2016-06-08 05:00:00"

precipData <- getPrecip(states = statesTSColin, 
                        startDate = startTSColin, 
                        endDate = endTSColin)
precipMap(precipData, 
          startDate = startTSColin, 
          endDate = endTSColin)
