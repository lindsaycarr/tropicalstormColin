# merge precip + streamflow data
library(dplyr)
library(tidyr)
library(dataRetrieval)
library(geoknife) #order matters because 'query' is masked by a function in dplyr
library(maps)

source('R/getPrecip.R')
source('R/visualizePrecip.R', echo=TRUE)

counties_fl <- c('Taylor', 'Madison', 'Hamilton', 'Lafayette', 'Suwannee', 'Columbia', 
                 'Baker', 'Union', 'Gilchrist', 'Dixie')
counties_ga <- c('Charlton', 'Ware', 'Camden', 'Glynn', 'Brantley', 'Clinch', 'McIntosh',
                 'Liberty', 'Bryan', 'Chatham', 'Wayne', 'Long', 'Effingham')
counties_sc <- c('Jasper', 'Beaufort', 'Colleton', 'Hampton', 'Charleston', 'Dorchester', 
                 'Berkeley', 'Williamsburg', 'Georgetown', 'Horry', 'Marion', 'Florence')
counties_nc <- c('Columbus', 'Brunswick', 'New Hanover', 'Pender', 'Duplin', 'Onslow',
                 'Carteret', 'Craven', 'Jones', 'Pamlico', 'Beaufort', 'Lenoir', 'Pitt',
                 'Hyde', 'Dare', 'Tyrrell', 'Washington', 'Martin', 'Bertie', 'Hertford',
                 'Gates', 'Chowan', 'Perquimans', 'Pasquotank', 'Camden', 'Currituck')

counties_df <- data.frame(state = c(rep("FL", length(counties_fl)), rep("GA", length(counties_ga)), 
                                    rep("SC", length(counties_sc)), rep("NC", length(counties_nc))),
                          county = c(counties_fl, counties_ga, counties_sc, counties_nc),
                          stringsAsFactors = FALSE) %>% 
  mutate(state_fullname = tolower(state.name[match(state, state.abb)])) %>% 
  mutate(county_mapname = paste(state_fullname, tolower(county), sep=",")) %>% 
  mutate(county = paste(county, 'County')) 

precipData <- getPrecip(counties_df)
precipMap(precipData)
