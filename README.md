# GeoData

_Conviértete en Geohacker_

#### ¿Qué es OSM?

En la mayoría de los países la información geográfica pública no es de libre uso. Al no estar considerada por las administraciones públicas como un servicio similar a una infraestructura de orden público, el usuario paga dos veces por esa información, la primera al generarla, a través de sus impuestos, y la segunda al adquirirla para su uso.

Así mismo, las licencias de uso a veces restringen su utilización al tener el usuario un derecho limitado de aplicación de la cartografía. No se puede corregir errores, añadir nuevos datos o emplear esos mapas de determinados modos (integración en aplicaciones informáticas, publicaciones, etc.) sin pagar por ellos.

OpenStreetMap es un proyecto abierto, social y de dimensiones gigantescas elaborado por personas normales.

Los mapas se crean utilizando información geográfica capturada con dispositivos GPS móviles, ortofotografías y otras fuentes libres. Esta cartografía, tanto las imágenes creadas como los datos vectoriales almacenados en su base de datos, se distribuyen bajo licencia abierta Open Database License (ODbL).nota 2

> El nombre del proyecto es OpenStreetMap una sola palabra designa una  única base de datos que abarca todo el mundo. A veces se le llama  erróneamente Open Street Map o peor OpenStreetMaps. -Sergio Sevillano, cofundador de OSM España

![DF high roads and cycleways at zoom 15](https://raw.githubusercontent.com/rodowi/geo-is-osm/master/images/highroads-cycles-df-z15.png)

#### ¿Qué es un GeoHacker?

#### ¿Qué son los Geodatos?

Los geodatos son información acerca de ubicaciones geográficas almacenadas en un formato que se puede usar con un sistema de información geográfica (SIG).

Los geodatos se pueden almacenar en una base de datos, geodatabase, shapefile, cobertura, imagen de ráster o incluso en una tabla dbf u hoja de cálculo de Microsoft Excel. La siguiente es una lista de geodatos que se puede usar con el software SIG de Esri junto con vínculos a temas que los describen:

#### ¿Qué son R?

R es un entorno y un lenguaje de programación enfocado en el análisis estadístico de los más utilizados en el campo de la minería de datos que pueden aplicarse a gran variedad de disciplinas.

Este lenguaje forma parte de GNU y se distribuye bajo licencia GNU GLP.

#### ¿Qué son RStudio?

[RStudio](https://www.rstudio.com/) es un entorno de desarrollo integrado (IDE) para el lenguaje de programación R, dedicado a la computación estadística y gráficos. Incluye una consola, editor de sintaxis que apoya la ejecución de código, así como herramientas para el trazado, la depuración y la gestión del espacio de trabajo.

#### ¿Qué son Leaflet?

[Leaflet](https://rstudio.github.io/leaflet/) es una librería open-source JavaScript que permite crear mapas interactivos para la web y para entorno móvil de manera fácil. Pesa apenas unos 33 KB.

Con esta biblioteca podemos usar mapas base de Google, ESRI, OpenStreetMap, entre otros, agregar marcadores, polígonos, líneas, realizar zoom y extender su funcionalidad con una buena cantidad de plugins, entre ellos, muchos desarrollados por ESRI.

Empresas como Flickr, Facebook, CartoDB, Washington Post y OpenSteetMap hacen uso de Leaflet.

```[R]
var map = L.map('map').setView([6.241127, -75.560000], 13);
L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
    attribution: '© OpenStreetMap contributors'
}).addTo(map);
```

![](https://3.bp.blogspot.com/-z1ZRrFcPhnA/WA_QgSy08KI/AAAAAAAAI08/XG_xs0NU8r02cMEFkCWbBbZvhVNYK73NwCLcB/s400/leaflet_blog.PNG)

## Inicio

1. Instalación de Rstudio
2. Instalación de la paquetería de Leaflet
3. Descargar los archivos de este repositorio

# Map Components

- The `leaflet` map object (SVG).

- Tile Layers. <sup>1</sup>

- Vector Data Layers (points, lines, circles, rectangles, polygons).

- Raster Data Layers.

- Popups and labels.

- Controls (zoom control, layer control, buttons, attribution, legends).

- Custom controls and layers via lots and lots of  [plugins](http://www.leafletjs.com/plugins.html).

.footnote[
[1] [How web maps work](https://www.mapbox.com/help/how-web-maps-work/).
]

---

# Advanced Concepts

- Visualizations are organized into various panes. Different panes have different zIndex for overlay.

- Events are emitted for various actions and can be acted upon by registering event listeners for appropriate events.

- Data can be organized into groups which allows bulk operations on grouped data.

- Many 3rd-Party vendors (commercial and open-source) provide add-ons on top of Leaflet. e.g. ESRI, Mapbox, GIBs. 

---

class: inverse, center, middle

# BEGINNER

---

# Building a Map

```{r eg0, eval=FALSE}
leaflet(data) | leafletProxy() %>% 
  
  
  setView(lat, lon, zoom) # Initial View OR
  fitBounds(lat_se, lon_se, latnw, lon_nw) # Initial Bounds
  setMaxBounds(lat_se, lon_se, latnw, lon_nw) # Max Bounds
  
  addTiles() | addProviderTiles() | addWMSTiles() #Tiles
  
  addMarkers() | addCircleMarkers() |
    addAwesomeMarkers() | addLabelOnlyMarkers() # Markers
  
  addPolylines() | addCircles() |
  addRectangles() | addPolygons() # Shapes
  
  addRasterImage(image) # Raster Data
  
  addLegend() | addLayersControl() | addControl() # Controls
  
```

.footnote[
- A Map is built by piping (`%>%`) several add* methods.

- `leaflet()`/`addXXX()` methods take an optional `options` argument for customization.
]

---

# Minimal Example

```{r eg1.print, eval=FALSE}
library(leaflet)
leaflet()
```

```{r eg1, echo=FALSE, message=FALSE, warning=FALSE}
leaflet() %>%
  frameWidget(height='275')
```

Wait, What? Where's my map?

---

# Tiles

```{r eg2.print, eval=FALSE}
leaflet() %>%
  addTiles()
```

```{r eg2, echo=FALSE, message=FALSE, warning=FALSE}
leaflet() %>%
  addTiles() %>% setMapWidgetStyle() %>%
  frameWidget(height='275')
```

- Defaults to OpenStreetMap tiles. Custom URL can be provided via the `urlTemplate` param.
- `tileOptions()` can be used for customizing the tile layer.

---

# Provider Tiles

```{r eg3.print, eval=FALSE}
leaflet() %>%
  addProviderTiles(providers$CartoDB.DarkMatter, group="Dark") %>%
  addProviderTiles(providers$CartoDB.Positron, group="Light") %>%
  addLayersControl(baseGroups=c('Dark','Light'))
```

```{r eg3, echo=FALSE, message=FALSE, warning=FALSE}
leaflet() %>%
  addProviderTiles(providers$CartoDB.DarkMatter, group="Dark") %>%
  addProviderTiles(providers$CartoDB.Positron, group="Light") %>%
  addLayersControl(baseGroups=c('Dark','Light')) %>%
  setMapWidgetStyle() %>%
  frameWidget(height='275')
```


There are more than 100 tile providers available via the `providers` list.

---

# Markers

- Represent unique locations on the map.

- Added using `addMarkers`, `addCircleMarkers`, `addAwesomeMarkers`, `addLabelOnlyMarkers`.

- Input can be vectors of lat/lon coordinates, data.frame, `sp::SpatialPoints`, `sp::SpatialPointsDataFrame`. 

- Can have labels, and popups whose content can be derived from the data.

- Can be toggled using grouping.

- Can be clustered for better performance and visual aesthetics.

---

# Adding Markers

```{r eg4, eval=FALSE}

leaflet(data) %>%
  
  addMarkers(
    lat = ~latitude, lon = ~longitude,
    
    options = markerOptions(),
  
    label=~label, labelOptions = labelOptions(),
    popup=~popup, popupOptions = popupOptions(),
    
    clusterOptions = clusterOptions(),
    
    group = 'Group-A')

  # Similarly 
  addCircleMarkers()  # Fixed scale Circles
  addAwesomeMarkers() # More choices for icons
  addLabelOnlyMarkers() # No icon
```

---

# Markers Example

```{r eg5.0, warning=FALSE}
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
```

---

# Markers Example

```{r eg5.1, echo=FALSE, message=FALSE, warning=FALSE}
l %>%
  frameWidget(height='440')
```

---

# Shapes

- Can be lines, circles, rectangles, polygons.

- Added using `addPolyLines`, `addCircles`, `addRectangles`, and `addPolygons`.

- For polylines: Input can be `sp::Lines`, `sp::SpatialLines`, `sp::SpatialLinesDataFrame`. 

- For polygons: Input can be `sp::Polygons`, `sp::SpatialPolygons`, `sp::SpatialPolygonsDataFrame`.

- Can have labels and popups whose content can be derived from data.

- Can have their appearance customized using data.

- Can be grouped for bulk operations.

- Can be highlighted on mouse-over.

---

# Adding Shapes

```{r eg6, eval=FALSE}

leaflet(data) %>%
  addPolygons(
    label=~label, labelOptions = labelOptions(),
    popup=~popup, popupOptions = popupOptions(),
             
    # Shape Options
    options = pathOptions(),
    weight = 1, opacity=0.8, color = "#000000",
    fillColor="#ff0000", fillOpacity=0.7,
             
    # Highlighting on mouse-over
    highlightOptions = highlightOptions(
      color='#00ff00', weight = 2,
      opacity = 1, fillOpacity = 1,
      bringToFront = TRUE, sendToBack = TRUE),
             
    group = 'Group-A')

  #Similarly
  addCircles()
  addPolylines()
  addRectangles()
```

---

# Shapes Example

```{r eg 7.0, echo=FALSE, warning=FALSE}
library(magrittr)
fName <- 'world-population.geo.json'
spdf <- geojsonio::geojson_sp(rmapshaper::ms_simplify(readr::read_file(fName)))
spdf@data %<>% dplyr::mutate(
  AREA = as.numeric(as.character(AREA)),
  POP2005 = as.numeric(as.character(POP2005))
)

spdf <- subset(
  spdf,
  !(is.na(AREA) | AREA <1 | is.na(POP2005) | POP2005<1)
)

spdf@data %<>%
  dplyr::mutate(
  POPDENSITY = POP2005/AREA
)

spdf.world <- spdf
```

```{r eg7.1}
# spdf is a sp::SpatialPolygonsDataFrame
qpal <- colorQuantile(rev(viridis::viridis(5)),
                      spdf$POPDENSITY, n=5)

l <- leaflet(spdf, options =
               leafletOptions(attributionControl = FALSE, minzoom=1.5)) %>%
  addPolygons(
    label=~stringr::str_c(
      NAME, ' ',
      formatC(POPDENSITY, big.mark = ',', format='d')),
    labelOptions= labelOptions(direction = 'auto'),
    weight=1,color='#333333', opacity=1,
    fillColor = ~qpal(POPDENSITY), fillOpacity = 1,
    highlightOptions = highlightOptions(
      color='#000000', weight = 2,
      bringToFront = TRUE, sendToBack = TRUE)
    ) %>%
  addLegend(
    "topright", pal = qpal, values = ~POPDENSITY,
    title = htmltools::HTML("Population Density<br/>(2005)"),
    opacity = 1 )

```

---

# Shapes Example

```{r eg7.2, echo=FALSE, message=FALSE, warning=FALSE}
l %>% setMapWidgetStyle() %>%
  frameWidget(height='400', width='95%')
```

- Performance Tip: Use `rmapshaper::ms_simplify` with impunity!

---

# Other Misc. Stuff

- `addRasterImage` for adding raster image data. [Example](https://rstudio.github.io/leaflet/raster.html).

- `addMiniMap` for a small map inside the main map at a zoom offset. [Example](http://rpubs.com/bhaskarvk/leaflet-minimap).

- `addMeasure` to measure distances/area. [Example](http://rpubs.com/bhaskarvk/leaflet-measure).

- `addGraticule` adds a graticule. [Example](http://rpubs.com/bhaskarvk/leaflet-graticule).

- `addEasyButton`/`addEasyButtonBar` for customized buttons [Example](http://rpubs.com/bhaskarvk/easybutton).

- `addControl` for custom Control element.

- `addScaleBar` to display a scale.

---

class: inverse, center, middle

# INTERMEDIATE

---

# Projections

- ALL MAPS OF EARTH ARE WRONG! Obligatory [XKCD](http://xkcd.com/977/) ref.

- By Default leaflet ...

  + uses [EPSG:3857](http://epsg.io/3857) (a.k.a. Spherical Mercator) projection to display data/tiles.

  + expects tiles in EPSG:3857.

  + expects input vector/raster data in lat/lon [EPSG:4326](http://epsg.io/4326) and internally converts them to EPSG:3857 before plotting.

- Which means ...

  + You can't use tile services which provide tiles in non-spherical-Mercator projections.

  + You need to convert any vector/raster data in any non-epsg:4326 to epsg:4326 before adding to the leaflet map.

---

# Proj4Leaflet

- Enter [Proj4Leaflet](https://github.com/kartena/Proj4Leaflet/) a leaflet plugin allowing use of [proj4js](https://github.com/proj4js/proj4js) to display map in non-spherical-Mercator projection.

- Basic use 

```{r eg8, eval=FALSE}
leaflet(options = 
          leafletOptions(crs = leafletCRS()))
```

- So now you can display data/tiles in a non-spherical-Mercator projection.

- But you still need to specify vector/raster data in EPSG:4326 (lat/lon) which will get internally converted to the custom projection specified.

- Another caveat: You can have only one projection at a time which is set during initialization. To change projection you need to destroy and rebuild the map.

---

# Projections Example 1.

```{r eg9.0, echo=FALSE}
spdf <- spdf.world
```

```{r eg9.1}
crs.molvidde <- leafletCRS(
  crsClass="L.Proj.CRS", code='ESRI:53009',
  proj4def= '+proj=moll +lon_0=0 +x_0=0 +y_0=0 +a=6371000 +b=6371000 +units=m +no_defs',
  resolutions = c(65536, 32768, 16384, 8192, 4096, 2048))

l <- leaflet(
  spdf,
  options = leafletOptions(
    maxZoom = 5, crs= crs.molvidde, attributionControl = FALSE)) %>%
  addGraticule(style= list(color= '#999', weight= 0.5, opacity= 1)) %>%
  addGraticule(sphere = TRUE,
               style= list(color= '#777', weight= 1, opacity= 0.25)) %>%
  addPolygons(
    label=~stringr::str_c(
      NAME, ' ', formatC(POPDENSITY, big.mark = ',', format='d')),
    labelOptions= labelOptions(direction = 'auto'),
    weight=1,color='#ffffff', opacity=1,
    fillColor = ~qpal(POPDENSITY), fillOpacity = 1,
    highlightOptions = highlightOptions(
      color='#000000', weight = 2,
      bringToFront = TRUE, sendToBack = TRUE)) 
```

---

# Projections Example 1.

```{r eg9.3, echo=FALSE, message=FALSE, warning=FALSE}
l %>%
  setView(10,0,0.5) %>% setMapWidgetStyle() %>%
  frameWidget(height='440')
```

---

# Projections Example 2.

```{r eg10.0}
spdf <- rmapshaper::ms_simplify(albersusa::usa_composite())
pal <- colorNumeric(palette = "Blues", domain = spdf@data$pop_2014)

crs.laea <- leafletCRS(
  crsClass="L.Proj.CRS", code='EPSG:2163',
  proj4def='+proj=laea +lat_0=45 +lon_0=-100 +x_0=0 +y_0=0 +a=6370997 +b=6370997 +units=m +no_defs',
  resolutions = c(65536, 32768, 16384, 8192, 4096, 2048,1024, 512, 256, 128))

l <- leaflet(
  options= leafletOptions(
    worldCopyJump = FALSE, crs=crs.laea, attributionControl = FALSE)) %>%
  addPolygons(
    data=spdf, label=~stringr::str_c(
      name, ' ', formatC(pop_2014, big.mark = ',', format='d')),
    labelOptions= labelOptions(direction = 'auto'),
    weight = 1, color = "#000000",
    fillColor=~pal(pop_2014), fillOpacity=0.7,
    highlightOptions = highlightOptions(
      color='#ff0000', opacity = 1, weight = 2, fillOpacity = 1,
      bringToFront = TRUE, sendToBack = TRUE))
```

---

# Projections Example 2.

```{r eg10.1, echo=FALSE, message=FALSE, warning=FALSE}
l %>%
  fitBounds(-125, 24 ,-75, 45) %>%
  setMaxBounds(-125, 24 ,-75, 45) %>%
  setMapWidgetStyle() %>% 
  frameWidget(height='400')
```

---

# Projections Example 3.


```{r eg11.0, echo=FALSE}
suppressPackageStartupMessages(library(tilegramsR))

states <- FiveThirtyEightElectoralCollege.states@data$state
factpal <- colorFactor(
  colormap::colormap(nshades = length(states), 
                     colormap = colormap::colormaps$jet ), 
  states)
```

```{r eg11.1}
l <- leaflet(
  options=leafletOptions(
    crs = leafletCRS("L.CRS.Simple"),
    minZoom = -2, maxZoom = -2,
    dragging = FALSE, zoomControl = FALSE, attributionControl = FALSE)) %>%
  addPolygons(
    data=FiveThirtyEightElectoralCollege,
    weight=1,color='#000000', fillOpacity = 0.5, opacity=0.2,
    fillColor= ~factpal(state)) %>%
  addPolygons(
    data=FiveThirtyEightElectoralCollege.states, group = 'states',
    weight=2,color='#000000',
    fill = T, opacity = 1, fillOpacity = 0,
    highlightOptions = highlightOptions(weight = 4)) %>%
  addLabelOnlyMarkers(
    data=FiveThirtyEightElectoralCollege.centers,
    label = ~as.character(state),
    labelOptions = labelOptions(
      noHide = 'T', textOnly = T,
      offset=c(-8,-20), textsize = '12px'))
```

---

# Projections Example 3

```{r eg11.2, echo=FALSE, message=FALSE, warning=FALSE}
l %>%
  leaflet.extras::setMapWidgetStyle() %>%
  setMapWidgetStyle() %>% 
  frameWidget(height='450')
```

---

# Shiny

- Use `leafletProxy()` to update already existing map.

- Use `clear*` methods to remove stuff already on a map.

- leaflet package traps many leaflet [events](http://leafletjs.com/reference.html#map-events) and makes then available as shiny events.

- Use `observeEvent(input$<MAP_ID>_<EVENT_NAME>)` to act on these events.

---

# leaflet.extras

- [R package](https://bhaskarvk.github.io/leaflet.extras/) that enhances the `leaflet` package. Developed by yours truly to integrate the plethora of leaflet plugins available.<sup>1</sup>

-  Not yet on CRAN.
  `devtools::install_github('bhaskarvk/leaflet.extras')`

- Actively being developed and maintained. Contributions welcome.

- `leaflet` package will be stable and `leaflet.extras` will be very dynamic.

.footnote[
[1] I also have [leaflet.esri](https://bhaskarvk.github.io/leaflet.esri/) and [leaflet.mapbox](https://bhaskarvk.github.io/leaflet.mapbox/) packages under heavy development.
]

---

# leaflet.extras

- Add/Modify/delete/style markers/shapes using [Leaflet.Draw](http://rpubs.com/bhaskarvk/leaflet-draw).

- Add [GeoJSON](http://rpubs.com/bhaskarvk/geojsonv2), [TopoJSON](http://rpubs.com/bhaskarvk/topojsonv2), [KML](http://rpubs.com/bhaskarvk/kml), [GPX](http://rpubs.com/bhaskarvk/gpx), [CSV](http://rpubs.com/bhaskarvk/csv) files directly.
  + Customizable Markers and Shapes
  + Choropleths from polygon data w/ auto legends and bi-directional highlighting
  + Popup showing properties in a tables

- Create [Heatmap](http://rpubs.com/bhaskarvk/leaflet-heatmap) from point data.

- [Search](http://rpubs.com/bhaskarvk/leaflet-search) Markers. Geo-locate using OSM Nominatum API.

- [Pulsating](http://rpubs.com/bhaskarvk/leaflet-pulseIcon) and [Weather](http://rpubs.com/bhaskarvk/leaflet-weather) icons for markers.

- [Tiles Caching](http://rpubs.com/bhaskarvk/TileLayer-Caching), [GPS](https://github.com/stefanocudini/leaflet-gps), and many more!

---

# TopoJSON Example

```{r eg12.0}
library(leaflet.extras)
fName <- 'crimes_by_district.topojson'

l <- leaflet() %>%
  addBootstrapDependency() %>%
  setView(-75.14, 40, zoom = 11) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addGeoJSONChoropleth(
    readr::read_file(fName), valueProperty ='incidents',
    scale = 'OrRd', mode='q', steps = 5, padding = c(0.2,0),
    popupProperty = propstoHTMLTable(
      props = c('dist_numc', 'location', 'incidents', '_feature_id_string'),
      table.attrs = list(class='table table-striped table-bordered'),drop.na = T),
    labelProperty = JS('function(feature){return "WARD: " + feature.properties.dist_numc;}'),
    color='#ffffff', weight=1, fillOpacity = 0.7,
    highlightOptions = highlightOptions(
      fillOpacity=1, weight=2, opacity=1, color='#000000',
      bringToFront=TRUE, sendToBack = TRUE),
    legendOptions = legendOptions(title='Crimes', position='topright'))
```

---

# TopoJSON Example

```{r eg12.1, echo=FALSE, message=FALSE, warning=FALSE}
l %>%
  frameWidget(height='450')
```

---

class: inverse, center, middle

# ADVANCED

## Mostly for leaflet devs.

---

# Under the hood!

- Not your grandpa's htmlwidget!

- Source code organization
```
    leaflet
    |_R               - Contains R files
    |_javascript/src  - contains JS binding code written in ES2015.
    |_inst/_htmlwidgets/
      |_leaflet.js  - JS binding file transpiled from ES2015 files.
      |_leaflet.yml - widget YAML file
      |_lib/        - leaflet JS files + some plugins
      |_plugins/    - some more plugins
      |_examples/   - more examples than you can care for!
```

- You need Node.js and NPM for building.

```bash
    # Do this onetime
    npm install -g grunt-cli
    cd leaflet && npm install
    grunt build # Do this everytime you change javascript/src files.
```

---

# Important files

```
  R
  |_leaflet.R          - Widget initializing code
  |_layers.R           - add/remove layers (tiles/markers/shapes)
  |_normalize.R        - Data normalization/extraction
  |_colors.R           - Color generation code
  |_shiny.R            - Shiny stuff
  |_utils.R            - odds-n-ends
  |_plugin*R           - R code for misc plugins
  
  javascript/src
  |_index.js               - Widget initialization JS code.
  |_methods.js             - LeafletWidget.methods object
  |_dataframe.js           - JS eq. of a R data.frame
  |_layer-manager.js       - Manages layers
  |_crs_utils.js           - projections support
  |_cluster-layer-store.js - Marker clustering
  |_util.js                - odds-n-ends
  
```

---

# Important R functions


-  `derivePoints`/`derivePolygons` - extracts coordinates from various types of data.
  
- `resolveFormula` - extracts values for various params from data using formulas. e.g. `addMarkers(data=df, lat=~lat, lon=~lon, label=~name)`.
  
- `filterNULL` - removes NULLs from list. **Very useful!**
  
- `getMapData` - retrieves map data stored in the `leaflet()` instance.
  
- `invokeMethod` - Calls a JS method defined in `LeafletWidget.methods` JS Object.
  
- `htmlwidgets::onRender` - Used to invoke custom JS code after the map has been initialized.

---

# THANK YOU!

<hr/><br/>

### Twitter: [@alexfuser](https://twitter.com/alexfuser)

### LinkedIn: [alexfuser](https://www.linkedin.com/in/alexfuser)

### Github: [alexfuser](https://github.com/alexfuser)



Aquí encontrarás uso de datos abiertos, análisis de datos geoespaciales, desarrollo de software, visualización de datos, y cartografía.

Pasa a la Wiki para ver el contenido: https://github.com/rodowi/geo-is-osm/wiki
