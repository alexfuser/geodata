library(leaflet)
library(magrittr)

library("rgdal")
library("maptools")
library("leaflet")
library("htmlwidgets")

SFMap <- leaflet() %>%
  addTiles() %>%
  setView(lng=-122.42,lat=37.78,zoom=13)%>%
  addCircleMarkers(-122.42, 37.78,popup="SF Bay area")
SFMap

saveWidget(SFMap, 'mapfrance.html', selfcontained = FALSE)



