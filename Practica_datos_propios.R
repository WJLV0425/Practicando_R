# Author: Welifer Lebron  Vicente
# Student and Research Assistant at Universidad Autónoma de Santo Domingo (UASD).
# Date: January, 2021.

#PRACTICANDO CON DATOS PROPIOS.

# Cargar paquetes

library(sp)
library(sf)
library(rgdal)
library(GISTools)
library(maptools)
library(RColorBrewer)
library(tmap)
library(vegan) # Para visualizar los datos con la función view().



Mapa_RD = readOGR(encoding = "UTF-8", "C:/Users/welifel/Documents/GIS DataBase/ShapeFilesCenso2010", "PROVCenso2010") #Para leer shapefile en R. readOGR(ubicación, nombre)
str(Mapa_RD)
plot(Mapa_RD)
head(Mapa_RD@data) #Muestra 5 primeras filas.
View(Mapa_RD@data) #Muestra todos los datos.

choropleth(Mapa_RD, as.numeric(as.factor(Mapa_RD$TOPONIMIA)))
unique(Mapa_RD$TOPONIMIA) #32 valores únicos.
colors = colorRampPalette(brewer.pal(12, "Set3"))(33)
Mapa_RD$TOPONIMIA = as.factor(as.character(Mapa_RD$TOPONIMIA))
spplot(Mapa_RD, "TOPONIMIA", main = "República Dominicana: División Administrativa de Segundo Nivel", col.regions = colors, col = "White", order(Mapa_RD$TOPONIMIA))


# Uso del paquete tmap


# load a map
Mapa_RD = readOGR( encoding = "UTF-8", "C:/Users/welifel/Documents/GIS DataBase/ShapeFilesCenso2010", "PROVCenso2010")
#head(map_bd@data)
str(Mapa_RD@data)
Mapa_RD$TOPONIMIA = as.factor(Mapa_RD$TOPONIMIA)
Mapa_RD$TOPONIMIA = as.numeric(Mapa_RD$TOPONIMIA)
Mapa_RD$TOPONIMIA = as.character(Mapa_RD$TOPONIMIA)
class(Mapa_RD$TOPONIMIA)

qtm(shp = Mapa_RD, fill = "TOPONIMIA")


# Similar to ggplot2, we can add subsecuent layers in tmap for plotting.
tm_shape(Mapa_RD) + #shapefile usado.
  tm_borders() + #Capa de bordes.
  tm_fill(col="TOPONIMIA", ) + # Variable contenedora de la información a representar.
  tm_compass() + # This puts a compass on the bottom right of the map 
  tmap_style("classic") + #Supongo que este estilo es lo que proporciona los colores del mapa, por lo que es necesario buscar otros estilos.
  tm_layout(legend.outside = TRUE) +
tmap_options(max.categories = 33)


# Labeling
tm_shape(Mapa_RD) +
  tm_fill(col = "TOPONIMIA", style = "quantile") +
  tm_borders() +
  tm_text(text = "TOPONIMIA", size = 0.7)

# Another
tm_shape(Mapa_RD) +
  tm_fill(col = "TOPONIMIA", style = "quantile", title = "Value of  quantitative indicator", palette = "Blues") + 
  tm_borders(col = "grey30", lwd = 0.6) +
  tm_text(text = "TOPONIMIA", size = 0.5) +
  tm_credits("Source: 11TH_DIMENSION_GUY", position = c("right", "top"))
