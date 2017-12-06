library(leaflet)
library(magrittr)

m <- leaflet() %>% 
  addTiles()%>%
  # a map with the default OSM tile layer
  setView(-93.65, 42.0285, zoom = 17)%>%
  addPopups(-93.65, 42.0285, 'Here is the <b>Department of Statistics</b>, ISU')
m