# get precip data

getPrecip <- function(counties_df, startDate = "2016-06-06 05:00:00", endDate = "2016-06-07 05:00:00"){
  
  wg_s <- webgeom(geom = 'derivative:US_Counties', attribute = 'STATE')
  wg_c <- webgeom(geom = 'derivative:US_Counties', attribute = 'COUNTY')
  wg_f <- webgeom(geom = 'derivative:US_Counties', attribute = 'FIPS')
  county_info <- data.frame(state = query(wg_s, 'values'), county = query(wg_c, 'values'), 
                            fips = query(wg_f, 'values'), stringsAsFactors = FALSE) %>% 
    unique() 
  
  counties_fips <- counties_df %>% left_join(county_info, by = c("state", "county"))
  
  stencil <- webgeom(geom = 'derivative:US_Counties',
                     attribute = 'FIPS',
                     values = counties_fips$fips)
  
  fabric <- webdata(url = 'http://cida.usgs.gov/thredds/dodsC/stageiv_combined', 
                    variables = "Total_precipitation_surface_1_Hour_Accumulation", 
                    times = c(as.POSIXct(startDate), 
                              as.POSIXct(endDate)))
  
  job <- geoknife(stencil, fabric, wait = TRUE)
  precipData <- result(job)
  precipData2 <- precipData %>% 
    select(-variable, -statistic) %>% 
    gather(key = fips, value = precipVal, -DateTime) %>% 
    left_join(counties_fips, by="fips")
  
  return(precipData2)
  
}




