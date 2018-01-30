
install.packages("devtools")
library(devtools)

install_github("tidyverse/ggplot2")
install_github("hrbrmstr/albersusa")


library(ggplot2)
library(sf)
library(dplyr)
library(ggmap)
library(viridis)
library(albersusa)



# Load shapefile as simple features
phillySF <- st_read('d:/philly-census-tract.shp', stringsAsFactors = FALSE)
plot(phillySF)

medianincome <- read.csv("d:/median-income-1970-2015.csv", stringsAsFactors = FALSE)


phillySF <- mutate(phillySF,GISJOIN = as.character(GISJOIN))
medianincome <- mutate(medianincome,GISJOIN = as.character(GISJOIN))

# Simple features look and feel much like data frames
phillyIncome <- left_join(phillySF,medianincome,by="GISJOIN")

# Make sure it is recognized as an SF object
phillyIncome <- st_as_sf(phillyIncome)

# Plot it using geom_sf()
ggplot() +
  geom_sf(data = phillyIncome, aes(fill = y2015), color = NA) +
  scale_fill_viridis(discrete = FALSE, direction = 1, option="magma")



# US state map - Albers USA Composite projection
states <- usa_sf()
plot(states)

ggplot() +
  geom_sf(data = states, aes(fill = pop_2010), color = NA) +
  scale_fill_viridis(discrete = FALSE, direction = 1, option="viridis")



# *** GEOCODING ***
ourCoords <- geocode("210 South 34th Street; Philadelphia, PA")
alsoOurCoords <- geocode("Meyerson Hall; Philadelphia, PA")
thisToo <- geocode("Meyerson Hall, PA")

geocode("210 South 34th Street") 	
geocode("210 S 34th st")


geocodeQueryCheck()


# Be careful about ambiguities
geocode("15 e 57th st, new york, ny") #-73.97275 40.76274
geocode("15 e 57th st, brooklyn, ny") #-73.92402 40.6557
geocode("15 e 57th st")               #-73.97275 40.76274



ourCoordsSF <- st_as_sf(ourCoords, coords = c("lon", "lat"), crs = 4326)

ggplot() +
  geom_sf(data = phillyIncome, aes(fill = y2015), color = NA) +
  geom_sf(data = ourCoordsSF, colour = "cyan", size = 6) +
  scale_fill_viridis(discrete = FALSE, direction = 1, option="magma")




