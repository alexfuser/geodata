library(leaflet)

leaflet() %>%
  addProviderTiles(providers$CartoDB.DarkMatter, group = "Dark") %>%
  addProviderTiles(providers$CartoDB.Positron, group = "Light") %>%
  addLayersControl(baseGroups = c('Dark', 'Light'))