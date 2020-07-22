
#Load Packages
library(tidyverse)
library(ggplot2)
library(ggstance)
library(skimr)
library(hexbin)
library(viridisLite)
library(viridis)
library(sf)
library(statebins)
library(mapdata)




#load Datasets
load("data/blue_jays.rda")
load("data/US_income.rda")

#Read in cdc
cdc <- read_delim(file = "data/cdc.txt", delim = "|") %>%
  mutate(genhlth = factor(genhlth,
                          levels = c("excellent", "very good", "good", "fair", "poor")))
         
#Exercise 1
ggplot(data=blue_jays, aes(Mass,Head))+
  geom_point(aes(Mass,Head), size = 1.5, alpha=(1/3)) + 
  geom_density_2d(aes(Mass,Head), size=0.4, binwidth = 0.004, color="black") +
  xlim(c(57,82))+
  theme_minimal()

#Exercise 2

#Plot 1

ggplot(data=cdc, aes(height,weight)) +
  geom_hex(bins=35) +
  labs(x= "Height (in)",
       y= "Weight (lbs)",
       fill = "Num. Obs.") +
  theme_minimal()

#Plot 2

ggplot(data=cdc, aes(height,weight)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", show.legend = FALSE) +
  facet_wrap(~gender) +
  labs (
    x="Height (in)",
    y="Weight (lbs)"
  ) +
  theme_minimal()
  


#Exercise 3

#Plot 1

il_counties <- map_data("county", "illinois") %>% select(lon = long, lat, group, id = subregion)

ggplot(il_counties, aes(lon,lat)) +
  geom_polygon(aes(group = group), fill = NA, colour = "grey50") + coord_quickmap() +
  theme_void() +
  labs(
    title = "Illinois"
  )







#Exercise 4

#Plot 1
US_income <- mutate(
  US_income,
  income_bins = cut(
    ifelse(is.na(median_income), 25000, median_income),
    breaks = c(0, 40000, 50000, 60000, 70000, 80000),
    labels = c("< $40k", "$40k to $50k", "$50k to $60k", "$60k to $70k", "> $70k"),
    right = FALSE
  )
)

ggplot(US_income, aes(geometry=geometry, fill =income_bins)) +
  theme_void() +
  geom_sf(size=0.2, color = "grey80") +
  scale_fill_viridis(discrete = TRUE) +
  labs(fill = "Median/nIncome") +
  coord_sf(datum = NA)

#Plot 2

ggplot(US_income, aes(state= name, fill = income_bins)) +
  scale_fill_viridis(discrete = TRUE) +
  labs(fill = "Median\nIncome") +
  geom_statebins() +
  theme_statebins()

  
  


       