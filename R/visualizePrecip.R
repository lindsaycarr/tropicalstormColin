
precipMap <- function(precipData){
  cols <- palette(blues9)[-1]
  precip_breaks <- seq(0, 80, by = 10)
  
  precipData_cols <- precipData %>% 
    group_by(state_fullname, county_mapname) %>% 
    summarize(cumprecip = sum(precipVal)) %>% 
    mutate(cols = cut(cumprecip, breaks = precip_breaks, labels = cols, right=FALSE))
  
  par(mar = c(0,0,0,0))
  
  m <- map('county', regions = precipData_cols$state_fullname, col = "lightgrey")
  map('state', regions = precipData_cols$state_fullname, 
           add = TRUE, lwd = 1.5, col = "darkgrey")
  map('county', regions = precipData_cols$county_mapname, 
           add = TRUE, fill = TRUE, col = precipData_cols$cols)
    legend(x = "bottomright", fill = cols, cex = 0.7, title = "Mean Precipitation (in)",
              legend = paste('<', precip_breaks[-1]))
  title("Cumulative Precipitation in the path of Tropical Storm Colin\n
        County-by-County Mean for [Time Period]",line = 2)  #title was being masked by geoknife
  #text(x=1,labels="subheader") #trying to make a subtitle of smaller font
}


