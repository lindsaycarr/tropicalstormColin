# get precip data

getPrecip <- function(states, startDate, endDate){
  
  wg_s <- webgeom(geom = 'derivative:US_Counties', attribute = 'STATE')
  wg_c <- webgeom(geom = 'derivative:US_Counties', attribute = 'COUNTY')
  wg_f <- webgeom(geom = 'derivative:US_Counties', attribute = 'FIPS')
  county_info <- data.frame(state = query(wg_s, 'values'), county = query(wg_c, 'values'), 
                            fips = query(wg_f, 'values'), stringsAsFactors = FALSE) %>% 
    unique() 
  
  counties_fips <- county_info %>% filter(state %in% states) %>%
    mutate(state_fullname = tolower(state.name[match(state, state.abb)])) %>%
    mutate(county_mapname = paste(state_fullname, tolower(county), sep=",")) %>%
    mutate(county_mapname = unlist(strsplit(county_mapname, split = " county")))
  
  stencil <- webgeom(geom = 'derivative:US_Counties',
                     attribute = 'FIPS',
                     values = counties_fips$fips)
  
  fabric <- webdata(url = 'http://cida.usgs.gov/thredds/dodsC/stageiv_combined', 
                    variables = "Total_precipitation_surface_1_Hour_Accumulation", 
                    times = c(as.POSIXct(startDate), 
                              as.POSIXct(endDate)))
  
  job <- geoknife(stencil, fabric, wait = TRUE, REQUIRE_FULL_COVERAGE=FALSE)
  check(job)
  precipData <- result(job, with.units=TRUE)
  precipData2 <- precipData %>% 
    select(-variable, -statistic) %>% 
    gather(key = fips, value = precipVal, -DateTime) %>% 
    left_join(counties_fips, by="fips")
  
  return(precipData2)
  
}
