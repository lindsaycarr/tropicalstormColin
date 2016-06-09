
precipMap <- function(precipData, startDate, endDate){
  cols <- colorRampPalette(brewer.pal(9,'Blues'))(9)
  precip_breaks <- c(seq(0,80,by = 10), 200)
  
  precipData_cols <- precipData %>% 
    group_by(state_fullname, county_mapname) %>% 
    summarize(cumprecip = sum(precipVal)) %>% 
    mutate(cols = cut(cumprecip, breaks = precip_breaks, labels = cols, right=FALSE)) %>% 
    mutate(cols = as.character(cols))
  
  par(mar = c(0,0,3,0))
  
  png('tsColin.png', width = 7, height = 5, res = 150, units = 'in')
  m1 <- map('county', regions = precipData_cols$state_fullname, col = "lightgrey")
  m2 <- map('state', regions = precipData_cols$state_fullname, 
            add = TRUE, lwd = 1.5, col = "darkgrey")
  
  # some county names are mismatched, only plot the ones that maps library 
  # knows about and then order them the same as the map
  precipData_cols <- precipData_cols %>%
    mutate(county_mapname = gsub(x = county_mapname, pattern = 'saint', replacement = 'st')) %>%
    mutate(county_mapname = gsub(x = county_mapname, pattern = 'okaloosa',
                                 replacement = 'okaloosa:main')) %>%
    filter(county_mapname %in% m1$names)
  precipData_cols <- precipData_cols[na.omit(match(m1$names, precipData_cols$county_mapname)),]
  
  m3 <- map('county', regions = precipData_cols$county_mapname, 
            add = TRUE, fill = TRUE, col = precipData_cols$cols)
  
  legend(x = "bottomright", fill = cols, cex = 0.7, bty = 'n', 
         title = "Cumulative\nPrecipitation (in)",
         legend = c(paste('<', precip_breaks[-c(1,length(precip_breaks))]), 
                    paste('>', tail(precip_breaks,2)[1]))) # greater
  graphics::title("Cumulative Precipitation from Tropical Storm Colin",
                  line = 2, cex.main=1.2)  #title was being masked by geoknife
  mtext(side = 3, line = 1, cex = 0.9, 
        text= paste("By county from", startDate, "to", endDate))
  dev.off()
}
