
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


# **** US county map - Albers USA Composite projection ****
counties <- counties_sf()
counties <- mutate(counties,fips=as.character(fips))
counties <- mutate(counties,fips=ifelse(state=="Alaska","02000",fips))


# **** 2016 Election Results ****
election <- read.csv("preselect16results.csv")
election <- filter(election,!is.na(county))  # remove all but the county-level data
election <- mutate(election,fips=as.character(fips)) # make "fips" a string
election <- mutate(election,fips = ifelse(nchar(fips)==4,paste0("0",fips),fips)) # add a leading "0" if it has a length of 4



elecjoin <- left_join(counties,election,c("fips","fips")) %>%
  filter(!is.na(lead)) %>%
  st_as_sf()

ggplot() +
  geom_sf(data = elecjoin, aes(fill = lead), color = NA) +
  scale_fill_manual(values = c('#cc3333', '#3333cc'))


# **** Design your theme ****
# Theme documentation: http://ggplot2.tidyverse.org/reference/theme.html
myTheme <- function() {
  theme_void() + 
    theme(
      text = element_text(size = 7),
      plot.title = element_text(size = 14, color = "#111111", hjust = 0, vjust = 0, face = "bold"), 
      plot.subtitle = element_text(size = 12, color = "#333333", hjust = 0, vjust = 0),
      axis.ticks = element_blank(),
      panel.grid.major = element_line(colour = "white"),
      legend.direction = "vertical", 
      legend.position = "right",
      plot.margin = margin(0, 0, 0, 0, 'cm'),
      legend.key.height = unit(1, "cm"), legend.key.width = unit(0.4, "cm"),
      legend.title = element_text(size = 9, color = "#111111", hjust = 0, vjust = 0, face = "bold"),
      legend.text = element_text(size = 8, color = "#111111", hjust = 0, vjust = 0)
    ) 
}

ggplot() +
  geom_sf(data = elecjoin, aes(fill = lead), color = NA) +
  scale_fill_manual(values = c('#cc3333', '#3333cc')) +
  myTheme()



# **** Set the projection (EPSG code) ****
# Complete listing here: http://spatialreference.org/
# 4326 - WGS 84 (standard lat,lng coordinates)
# 3395 - Mercator
# 102003 - Albers

ggplot() +
  geom_sf(data = elecjoin, aes(fill = lead), color = NA) +
  scale_fill_manual(values = c('#cc3333', '#3333cc')) +
  coord_sf(crs = st_crs(102003)) +
  myTheme()



# Display the county borders. Give the appearance of thinness using alpha.
# Set labels
# Set legend title

ggplot() +
  geom_sf(data = elecjoin, aes(fill = lead),
          #color="white", size=0.000001) +           # you can only get so thin
          color = alpha("white",0.2), size=0.1) +    # appearance of thinness
  scale_fill_manual(values = c('#cc3333', '#3333cc'),name = "Winner") +
  coord_sf(crs = st_crs(102003)) +
  labs(
    title = 'Results of the 2016 Presidential Election',
    subtitle = "Winning candidate in each U.S. county",
    caption = "Source: Mark Kearney"
  ) +
  myTheme()





