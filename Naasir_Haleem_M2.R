#Load Packages
library(tidyverse)
library(ggplot2)
library(ggstance)
library(skimr)
library(tibble)
library(ggthemes)
library(janitor)
library(ggrepel)
library(maps)
library(sf)
library(maptools)
library(mapdata)
library(cowplot)

#Load Data
nhdem <- read_delim(file = "data/NH_2016pp_dem.txt", delim = "|") 

nhrep <- read_delim(file = "data/NH_2016pp_rep.txt", delim = "|") 
  

load()

#Plot 1

# Setup NH map dataset
nh_dat <- maps::map(
  database = "county",
  regions = "new hampshire",
  plot = FALSE,
  fill = TRUE
) %>%
  # Provide comment!! 
  st_as_sf() %>%
  # Provide comment!!
  mutate(ID = str_remove(ID, ".*,")) %>% 
  # Provide comment!!
  rename(county = ID)

#nbagraph <- nba %>%
  #filter(g >= 10 , mp/g >= 5) %>% 

#Useful Numbers: 5 25 95

nhdem_result <- nhdem %>% 
  gather(key = candidate, value = votes, -county) %>% 
  group_by(county) %>% 
  summarise(ratio = max(votes)/nth(votes, 2, desc(votes))) %>% 
  left_join(nh_dat)

ggplot(nhdem_result, aes(geometry = geometry, fill = ratio)) +
  geom_sf() +
  scale_fill_gradient("Sanders to Clinton\nRatio", low = "white", high = "black", limits = c(1.0,3.0)) +
  theme_void() +
  theme(legend.justification = c(.3,.96),
        legend.position = c(.2,.9)) +
  labs(
    title = "Democratic Presidential Primary",
    subtitle = "New Hampshire (2016)"
    
  ) +
  coord_sf(datum = NULL)

nhrep_result <- nhrep %>% 
  gather(key = candidate, value = votes, -county) %>% 
  group_by(county) %>% 
  summarise(ratio = max(votes)/nth(votes, 2, desc(votes))) %>% 
  left_join(nh_dat)

plot02 <- ggplot(nhrep_result, aes(geometry = geometry, fill = ratio)) +
  geom_sf() +
  scale_fill_gradient("Trump to Kasich*\nRatio", low = "white", high = "black", limits = c(1.0,3.0)) +
  theme_void() +
  theme(legend.justification = c(.5,.95),
        legend.position = c(.2,.9)) +
  labs(
    title = "Republican Presidential Primary",
    subtitle = "New Hampshire (2016)") +
  coord_sf(datum = NULL)

cowplot::plot_grid(plot01, plot02, align = "h")


  
  
#nhdem_result <- nh_dat %>% 
  #select(geometry,county)
  
  

##Select example
bar_dat <- nuadmission %>%
  mutate(a = applications - admitted_students,
         b= admitted_students - matriculants,
         c = matriculants) %>% 
  select(year, a,b,c) %>% 
  gather(key = category, value = count, -year) %>% 
  arrange(year)


#Plot 2 Numbers: 5,10,15,1,2,3,0.2,0.1,0.9 Add some comments

set.seed(2468)

x <- c(rnorm(20,5,2),
       rnorm(20,10,2),
       rnorm(20,15,2))

white_noise <- c(rnorm(20,0,1),
                 rnorm(20,0,2),
                 rnorm(20,0,3))

y <- x + white_noise

Group <- rep(c("Low", "Medium", "High"), each = 20)

plot01 <- tibble(x,y, Group)

ggplot(plot01, aes(x,y, color = Group)) +
  stat_ellipse(geom = "polygon",
               aes(fill = Group),
               alpha = 0.2) +
  geom_point(aes(shape = Group), size = 3) +
  scale_color_discrete(limits = c("High","Medium","Low"))+
  scale_fill_discrete(limits = c("High","Medium","Low")) +
  scale_shape_discrete(limits = c("High","Medium","Low"))+
  theme_classic() +
  coord_fixed() +
  theme(legend.justification = c(0,1),
        legend.position = c(0.1, 0.9))

#Plot 3

x <- rep(seq(-1,1,0.01), 201)

y <- rep(seq(-1,1,0.01), each = 201)

plot_03 <- tibble(x,y) %>% 
  mutate (fill_amount = x^3 - y)

ggplot(plot_03, aes(x,y)) +
  geom_tile(aes(fill = fill_amount)) +
  coord_fixed() +
  scale_fill_gradient2(NULL, low = "red", high = "blue") +
  scale_y_continuous(expand = c(0,0)) +
  scale_x_continuous(expand = c(0,0)) +
  stat_function(fun = function(x)x^3, color = rgb (.50,0,.50) ) +
  annotate(geom = "text", label = "x", x = 0, y = 0.1, size = 8) +
  annotate(geom = "text", label = "3", x = 0.075, y = 0.15, size = 6) 
  
  










