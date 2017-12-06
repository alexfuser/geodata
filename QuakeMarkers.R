library(leaflet)
library(purrr)
library(dplyr)

quakes.df <- quakes %>% dplyr::mutate(
  mag.level = cut(mag,c(3.5,4.5,5.5,6.5),
                  labels = c('> 3.5 & <=4.5', '>4.5 & <=5.5', '>5.5 & <=6.5'))) %>%
  split(.$mag.level)

l <- leaflet() %>%
  addProviderTiles(providers$Esri.OceanBasemap)

names(quakes.df) %>%
  purrr::walk( function(df) {
    l <<- l %>%
      addMarkers(data=quakes.df[[df]], lng=~long, lat=~lat,
                 label=~as.character(mag), popup=~as.character(mag),
                 group = df,
                 clusterOptions = markerClusterOptions())
  })

l <- l %>%
  addLayersControl(
    overlayGroups = names(quakes.df),
    options = layersControlOptions(collapsed = FALSE)) %>%
  addMiniMap(tiles = providers$Esri.OceanBasemap, width = 120, height=80)

