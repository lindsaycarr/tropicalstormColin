# get precip data
library(dplyr)
library(geoknife) #order matters because 'query' is masked by a function in dplyr

# wg_c <- webgeom(geom = 'derivative:US_Counties', attribute = 'COUNTY')
# c <- query(wg_c, 'values')
# wg_f <- webgeom(geom = 'derivative:US_Counties', attribute = 'FIPS')
# f <- query(wg_f, 'values')
# wg_s <- webgeom(geom = 'derivative:US_Counties', attribute = 'STATE')
# s <- query(wg_s, 'values')
# florida_info <- data.frame(state = s, county = c, fips = f) %>% 
#   filter(state == "FL")
# 
# county <- c('Taylor County', 'Madison County')
# 

############ County ############

stencil <- webgeom(geom = 'derivative:US_Counties',
                   attribute = 'COUNTY',
                   values = 'Taylor County')

############ /// ############

############ HUC ############

# hucs <- c('03110102','03110101','03110103','03110205','031102011',
#           '03110203','03110204','03110202','03110206')
# hucs_query_string <- paste0('HUC8::', paste(hucs, collapse=','))
# 
# stencil <- webgeom(hucs_query_string)

############ /// ############

fabric <- webdata(url = 'http://cida.usgs.gov/thredds/dodsC/stageiv_combined', 
                  variables = "Total_precipitation_surface_1_Hour_Accumulation", 
                  times = c(as.POSIXct("2016-06-06 05:00:00"), 
                            as.POSIXct("2016-06-07 05:00:00")))

job <- geoknife(stencil, fabric, wait = TRUE)
precipData <- result(job)


