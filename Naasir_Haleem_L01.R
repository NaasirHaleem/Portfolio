# Lego fun ----------------------------------------------------------------

# Load Packages -----------------------------------------------------------
library(tidyverse)
library(ggstance)
library(skimr)

# 
#Load Data
load("data/legosets.rda")

# Inspect Data
legosets

View (legosets)

glimpse(legosets)

skim (legosets)

skim_with(numeric = list(hist = NULL), integer = list(hist = NULL))

#These functions enable us to get a broad look at the data to notice any irregularities


#USD MSRP 
avg_price_per_year <- legosets %>%
  filter(!is.na(USD_MSRP)) %>%
  group_by(Year) %>%
  summarise(Price = median(USD_MSRP))

ggplot(data = avg_price_per_year,
       aes(Year, Price)) + 
  geom_line(color = "purple", size = 0.5) +
  geom_point(size = 0.5) +
  labs(x = "Year" , 
       y = "Price(USD)",
       title = "Average price of Lego sets",
       subtitle = "Amounts are reported in current USD",
       caption = "Source: LEGO")
theme_minimal

#I made sure to exclude data points that had no values associated with them. This was done to prevent them from affecting the output.

#Pieces Per Year

pieces_per_year <- legosets %>%
  filter(!is.na(Pieces)) %>%
  filter(Year >= 1975) %>%
  mutate(Duplo = ifelse(Theme == "Duplo", "Duplo", "Lego")) %>%
  group_by(Year, Duplo) %>%
  summarise(Pieces = mean(Pieces),
            num_sets = n())

ggplot(data = pieces_per_year,
       mapping = aes(Year, Pieces)) +
  geom_line () + 
  facet_wrap(~Duplo)

# Here I separated out Duplo and Lego pieces since the question asked to do so.
# Also, Duplo pieces were created at a later point than normal Lego pieces. They also have a different trend associated with them.

#Number of Themes

legosets %>%
  distinct (Theme)

theme_counts <- legosets %>%
  count(Theme, sort = TRUE) %>%
  mutate (Theme= fct_inorder(Theme, ordered = TRUE))

theme_counts %>%
  filter(n>150) %>%
  ggplot(mapping = aes(x = n, y = fct_rev(Theme))) + 
  geom_barh(stat = "identity") +
  labs(x= "Number of Sets",
       y = NULL) +
  theme_minimal()

#Since there are many different themes, I made sure to restrict the themes to a minimum number of themes. This was done to make sure the output was not cluttered with themes that are rarely used.





