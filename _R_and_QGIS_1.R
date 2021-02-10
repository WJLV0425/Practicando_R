# Author: Welifer Lebron  Vicente
# Student and Research Assistant at Universidad Autónoma de Santo Domingo (UASD).
# Date: January, 2021.

## Bibliography: Hands-On Spatial Data Analysis with R and QGIS 3.2.2. (Islam S., 2018).

# FUNDAMENTALS OF GIS USING R AND QGIS.
# Data used in this operations is mainly from Bangladesh locations.

## In this script you'll learn: The basic of GIS and vector data; coordinate transformation in R and QGIS; visualizing quantitative and qualitative maps in R; to use *Open Street Maps (OMS)* as background.

# There are two main data types in QGIS: vector data and raster data.

# VECTOR DATA.
## Has three types: points, line, and polygons.
## Shapefile is a normally used format for vector data, it includes 6 to 7 files for each map. Recently is getting acknowledged the format Geopackage, which can contain all the information in just one file.

# PLOTTING POINT DATA.

# If we want to import a shapefile containing points, we can do so by writing the folowing:

# SpatialPoints
library(sp) # El paquete "sf" es una versión actualizada y más completa.
library(rgdal)
library(maptools)
map = readOGR("C:/Users/welifel/Documents/USB/DCIM/Camera/ESTUDIES/Conservación de Recursos Naturales/R/Practicando_R/Hands-On-Geospatial-Analysis-with-R-and-QGIS-master/Chapter02/Data","indicator")
plot(map)
class(map)

# Importing an excel file
bd_val = read.csv("C:/Users/welifel/Documents/USB/DCIM/Camera/ESTUDIES/Conservación de Recursos Naturales/R/Practicando_R/Hands-On-Geospatial-Analysis-with-R-and-QGIS-master/Chapter02/Data/r_val.csv", stringsAsFactors = FALSE) 
str(bd_val) #To check the structure of the data frame.
bd_val = read.csv("https://github.com/PacktPublishing/Hands-On-Geospatial-Analysis-with-R-and-QGIS/tree/master/Chapter02/Data/r_val.csv", stringsAsFactors = FALSE) # For opening csv files from github.

# Convert it into SpatialPointsDataframe, must be installed package "GISTools" in order to carry out some actions.
coordinates(bd_val) = c("lon", "lat")
str(bd_val)

plot(bd_val, col = "blue", pch = 19) # "pch" argument is used to select geometric forms to be plotted, in this case 19 = dots. 

# SpatialLines
highway = readOGR("C:/Users/welifel/Documents/USB/DCIM/Camera/ESTUDIES/Conservación de Recursos Naturales/R/Practicando_R/Hands-On-Geospatial-Analysis-with-R-and-QGIS-master/Chapter02/Data","dhaka_gazipur")
plot(highway)

#Spatialpolygons
map_dhaka = readOGR("C:/Users/welifel/Documents/USB/DCIM/Camera/ESTUDIES/Conservación de Recursos Naturales/R/Practicando_R/Hands-On-Geospatial-Analysis-with-R-and-QGIS-master/Chapter02/Data","dhaka")
plot(map_dhaka)


# Use max.level = 2 to show a reduced or succinct structure. This shows a more detailed structure as the number increases. "Slots = espacios", "CRS= Coordinate Reference System".
str(map_dhaka, max.level = 2)

# @data: Contains all the attribute information or data.
# @polygon: Stores information on polygons or coordinates.
# @bbox: contains information on the extent of the map or the coordinates of two of the corners of the bounding box.

# load another map
map_bd = readOGR("C:/Users/welifel/Documents/USB/DCIM/Camera/ESTUDIES/Conservación de Recursos Naturales/R/Practicando_R/Hands-On-Geospatial-Analysis-with-R-and-QGIS-master/Chapter02/Data","BGD_adm3_data_re")
head(map_bd@data) #with "head()" we call the first five rows of the attribute table now.

str(map_bd@polygons, max.level = 2) # To access to the information in all 66 polygons.

plot(map_bd)

# To see an specific element in our data we do so by using, for example: 6th element in the Polygons slot of map_bd : map_bd@polygons[[6]]
sixth_element = map_bd@polygons[[6]]
# Have a succinct display of the 7th element of the bd@Polygons
str(sixth_element, max.level = 2)

# Structure of the 2nd polygon inside seventh_element
str(sixth_element@Polygons[[2]], max.level = 2)

# plot() the coords slot of the 2nd element of the Polygons slot.
plot(sixth_element@Polygons[[2]]@coords)

# To acccess a column or attribute in a SpatialPolygonsdataFrame we can use $ or [[]] 
map_bd$NAME_3
# or
map_bd[["NAME_3"]]
map_bd$Shape_Area

# Adding point data on polygon data
plot(map_bd)
points(bd_val, pch=19, col="blue")

# To change projection we use spTransformation from the `rgdal` package. We can do so by using a CRS() argument inside spTransformation():

map_bd = spTransform(map_bd, CRS("+proj=longlat +datum=WGS84"))
class(map_bd)

# If we want to change the projection to any other layer's (shapefile's) projection inside CRS(), we can write proj4string() to get the CRS of a new layer and set it to that. Let's say we want to set the projection system of "a" to the projection system of layer "b", we can do so by writing the following:

 ## a = spTransformation(a, CRS(proj4string(b)))

# plot quantitative data
## We can plot quantitative values using the choropleth() of the GISTools package. We can generate a choropleth using the following commands:

library(GISTools)
choropleth(map_bd, as.numeric(map_bd$value2))

# Plot qualitative data
## Using spplot(), we can also plot qualitative data. First we need to convert this qualitative attribute or column of SpatialPolygonsDataFrame to a factor variable and use a suitable color range. Here we have picked seven color from the RColorBrewer package as there are seve unique values for the NAME_3 column.

#install.packages("RColorBrewer")
library(RColorBrewer)
dhaka_div = readOGR("C:/Users/welifel/Documents/USB/DCIM/Camera/ESTUDIES/Conservación de Recursos Naturales/R/Practicando_R/Hands-On-Geospatial-Analysis-with-R-and-QGIS-master/Chapter02/Data","dhaka_div")
# check how many unique elements map_bd$NAME_3 has by writing unique(dhaka_div$NAME_3)
unique(dhaka_div$NAME_3)
# There are 7 unique districts and so pick 7 colors
colors = colorRampPalette(brewer.pal(12, "Set3"))(7) # "12" is just a combination of colors, "7" the number of unique colors needed, "Set3" I must look it up later, lol. 
dhaka_div$NAME_3 = as.factor(as.character(dhaka_div$NAME_3))
spplot(dhaka_div, "NAME_3", main = "Coloring different districts of Dhaka division", col.regions = colors, col = "White") # "white" color usado en los contornos de los polígonos.


# Using tmap
## To plot quantitative and qualitative maps in a much easier way, we use the "tmap" package. For a simple choropleth map, we can use qtm() function and inside it, there are two arguments.

install.packages("tmap")
library(tmap)

# load a map
map_bd = readOGR("C:/Users/welifel/Documents/USB/DCIM/Camera/ESTUDIES/Conservación de Recursos Naturales/R/Practicando_R/Hands-On-Geospatial-Analysis-with-R-and-QGIS-master/Chapter02/Data","BGD_adm3_data_re")
#head(map_bd@data)
str(map_bd@data)
map_bd$value1 = as.factor(map_bd$value1)
map_bd$value1 = as.numeric(map_bd$value1)
class(map_bd$value1)

#str(map_bd@data)
qtm(shp = map_bd, fill = "value1") # "value1" fue convertida de factor a númerica para realizar el mapa. "map_bd" sería el shapefile importado. Se debe prestar mucha atención a la tabla de datos, en mi caso debí convertir character a factor, y finalmente, factor a numeric. 

# Similar to ggplot2, we can add subsecuent layers in tmap for plotting.
tm_shape(map_bd) + #shapefile usado.
  tm_borders() + #Capa de bordes.
  tm_fill(col="value1") + # Variable contenedora de la información a representar.
  tm_compass() + # This puts a compass on the bottom right of the map 
  tmap_style("cobalt") + #Supongo que este estilo es lo que proporciona los colores del mapa, por lo que es necesario buscar otros estilos.
  tm_layout(legend.outside = FALSE) 



## Run tm_layout(legend.outside = TRUE) para tener la leyenda fuera del marco del mapa.

## Run the tmaptools::palette_explorer() function to see possible palettes’ names.

# Using bubbles
## tm_bubbles() can be used instead of tm_fill():
tm_shape(map_bd) +
  tm_bubbles(size = "value1", style = "quantile") + #look up for more styles.
  tm_borders(col="orange3") # Add a colorful border

# Labeling
tm_shape(map_bd) +
  tm_fill(col = "value1", style = "quantile") +
  tm_borders() +
  tm_text(text = "NAME_3", size = 0.7)

# Another
tm_shape(map_bd) +
  tm_fill(col = "value1", style = "quantile", title = "Value of  quantitative indicator", palette = "Blues") + 
  tm_borders(col = "grey30", lwd = 0.6) +
  tm_text(text = "NAME_3", size = 0.5) +
  tm_credits("Source: Author", position = c("right", "top"))

