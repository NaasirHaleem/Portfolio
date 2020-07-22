#Load Packages
library(tidyverse)
library(ggplot2)
library(ggstance)
library(skimr)
library(tibble)
library(ggthemes)
library(janitor)
library(ggrepel)
library(rapportools)
library(grid)
library(jpeg)
library(viridis)

#Load Datasets
stephdat <- read_delim(file = "data/stephen_curry_shotdata_2014_15.txt", delim = "|") %>% 
  clean_names()


#Plot 1
#12 and 14
ggplot(stephdat, aes(x = period, y = shot_distance, group = period)) +
  geom_boxplot(varwidth = TRUE) +
  facet_wrap(~event_type) +
  labs(title = "Stephen Curry\n2014-2015") +
  theme_minimal() +
  theme(title = element_text(face = "bold", size = 14),
        axis.title.x = element_text(face = "bold", size = 12),
        text = element_text(face = "bold", size = 14),
        axis.text.x = element_text(face = "plain", size = 10),
        axis.text.y = element_text(face = "plain", size = 10),
        panel.grid.major = element_blank(),
        panel.grid.minor.x = element_blank()) +
  scale_y_continuous(labels = scales::unit_format(unit = "ft"), expand = c(0,0)) +
  scale_x_continuous(breaks = c(1,2,3,4,5), labels = c("Q1","Q2", "Q3", "Q4", "OT") ) +
  xlab("Quarter/Period") +
  ylab("") 

#Plot 2
#0.04, 0.07, 0.081, 0.3, 3, 14, 27
ggplot(stephdat, aes(x = shot_distance, group = event_type, fill = event_type)) +
  scale_fill_manual(values = c("green", "red")) + 
  scale_x_continuous(labels = scales::unit_format(unit = "ft")) +
  annotate(geom = "text", label = "Made Shots", x = 8, y = .04, size = 4) +
  annotate(geom = "text", label = "Missed Shots", x = 32, y = .07, size = 4) +
  geom_density(alpha = 0.3) +
  theme_minimal() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.y = element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_blank(),
        legend.position = "none") +
  labs(title = "Stephen Curry\nShot Densities (2014-2015")

#Plot 3
#0.7, 14, 15, 20, na.value, control the na.value. scale that will have problem will be fill. 
  # Provide comment!!
  court <- rasterGrob(readJPEG(source = "data/nbahalfcourt.jpg"),
                      width = unit(1, "npc"), height = unit(1, "npc")
  ) 
ggplot(data = stephdat) +
   # Provide comment!!
    annotation_custom(
      grob = court,
      xmin = -250, xmax = 250,
      ymin = -52, ymax = 418
    ) +
    coord_fixed() +
    xlim(250, -250) +
    ylim(-52, 418) +
  geom_hex(aes(x = loc_x, y = loc_y), bins = 20, alpha = 0.7,color = "grey70") +
  scale_fill_gradient("Shot\nAttempts", low = "yellow",high= "red",limits = c(0,15), labels = c(
    "0","5","10","15+"
  ), na.value = "red"  ) +
  theme_minimal() +
  labs(title = "Shot Chart\nStephen Curry") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.y = element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        title = element_text(face="bold"))


ggplot(data = stephdat) +
  # Provide comment!!
  annotation_custom(
    grob = court,
    xmin = -250, xmax = 250,
    ymin = -52, ymax = 418
  ) +
  coord_fixed() +
  xlim(250, -250) +
  ylim(-52, 418) +
  geom_point(aes(x = loc_x, y = loc_y, shape = event_type, color = event_type), size = 4) +
  scale_shape_manual( values = c(1,4), labels = c("Missed Shot", "Made Shot")) +
  scale_color_manual( values = c("green","red"), labels = c("Missed Shot", "Made Shot")) +
  theme_minimal() +
  labs(title = "Shot Chart\nStephen Curry") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.y = element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        title = element_text(face="bold"),
        legend.position = "bottom",
        legend.title = element_blank())




