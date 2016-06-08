
precipMap <- function(precipData){
  cols <- palette(blues9)[-1]
  precip_breaks <- seq(0, 80, by = 10)
  
  precipData_cols <- precipData %>% 
    group_by(state_fullname, county_mapname) %>% 
    summarize(cumprecip = sum(precip)) %>% 
    mutate(cols = cut(cumprecip, breaks = precip_breaks, labels = cols, right=FALSE))
  
  par(mar = c(0,0,0,0))
  
  m <- map('county', regions = precipData_cols$state_fullname, col = "lightgrey")
  map('state', regions = precipData_cols$state_fullname, 
           add = TRUE, lwd = 1.5, col = "darkgrey")
  map('county', regions = precipData_cols$county_mapname, 
           add = TRUE, fill = TRUE, col = precipData_cols$cols)
  legend(x = "bottomright", fill = cols, cex = 0.7, title = "Precipitation (inches)",
              legend = paste('<', precip_breaks[-1]))
}

