
############ HUC ############

library(httr)
library(rgdal)
library(magrittr)

# wfs <- 'http://cida.usgs.gov/gdp/geoserver/wfs'
# feature <- 'derivative:wbdhu8_alb_simp'
# plot_CRS <- '+init=epsg:2163'
# 
# destination <- tempfile(pattern = 'huc_shape', fileext='.zip')
# query <- sprintf('%s?service=WFS&request=GetFeature&typeName=%s&outputFormat=shape-zip&version=1.0.0', 
#                  wfs, feature)
# file <- GET(query, write_disk(destination, overwrite=T), progress())
# shp.path <- tempdir()
# unzip(destination, exdir = shp.path)
# hucs <- readOGR(shp.path, layer='wbdhu8_alb_simp') %>% 
#   spTransform(CRS(plot_CRS))
# unlink(destination)
# 
# 
# cols = rep(NA, length(counts.by.id))
# cols[!is.na(bin)] = pal[bin[!is.na(bin)]]
# 
# xlim <- c(-1534607.9,2050000.1) # specific to the transform we are using
# ylim <- c(-2072574.6,727758.7)
# 
# plot(hucs, add = FALSE, border = NA, lwd = 0.5, xlim = xlim, ylim = ylim)

############ /// ############

library(maps)

tscolin_states <- c('florida', 'georgia', 'south carolina','north carolina')
tscolin_counties <- data.frame(state = 'florida', 
                               county = c('taylor', 'madison'))
tscolin_counties_string <- paste(tscolin_counties$state, tscolin_counties$county, sep=",")

region_map_counties <- map('county', regions = ts_states, col = "grey")
region_map <- map('state', regions = ts_states, add = TRUE, lwd = 1.5)
highlight_counties <- map('county', regions = tscolin_counties_string, 
                          add = TRUE, fill = TRUE, col = 'cornflowerblue')



