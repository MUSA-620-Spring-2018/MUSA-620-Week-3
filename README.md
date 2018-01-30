# Week 3 - Geocoding and Simple Features


![US Election Map](https://github.com/MUSA-620-Spring-2018/MUSA-620-Week-3/blob/master/pres-election-map.png "US Election Map")

County-level election results

### Resources
- Simple Features: [documentation](https://cran.r-project.org/web/packages/sf/sf.pdf)
- Geocode via ggmap: [documentation](https://www.rdocumentation.org/packages/ggmap/versions/2.6.1/topics/geocode)
- Colors: [Paletton](http://paletton.com/) - tool for finding complimentary colors
- Colors: [ColorBrewer](http://colorbrewer2.org) - perceptually uniform color scales for maps
- Colors: [Colour Lovers](http://www.colourlovers.com/palettes/most-loved/all-time/meta) - most "loved" color palettes

## Assignment (optional)

Create a county-level election cartogram, with the areas scaled by the number of votes.

Due: 6-Feb-2018 before the start of class

![US Election Cartogram](https://github.com/MUSA-620-Spring-2018/MUSA-620-Week-3/blob/master/election-cartogram-counties.png "US Election Cartogram")

U.S. Election Cartogram

#### Description

Begin by exporting the election map we made in class, either the simple red-blue map or the one that scales by vote margin. Remember to transform the coordinates to WGS 84 (crs code 4326) before exporting.

`st_transform(st_as_sf(elecjoin),crs = 4326) %>%
  st_write("election-map.shp", driver = "ESRI Shapefile")`

Download [ScapeToad], a simple application for making cartograms. There is no installation required. Just download the .zip, unpack the contents, and run the ScapeToad.exe executable.

ScapeToad is very easy to use. Just import the shapefile layer, press the Create Cartogram button, and follow the instructions.
- Section 1: skip
- Section 2: "Spatial coverage" = the shapefile you just imported
- Section 3: "Cartogram attribute" = total votes ("ttl_vts") / "Attribute type" = Mass
- Section 4: skip
- Section 5: you can refine the quality of the transformatio here, or just use the default settings

Once ScapeToad finishes, export the transformed cartogram. Load it into R using "st_read()" and set the CRS to WGS 84.

`cartogram <- st_read('election-cartogram.shp', stringsAsFactors = FALSE)
st_crs(cartogram) = 4326`

Now you can plot it as you did the original election map.

