#Load Packages
library(tidyverse)
library(ggplot2)
library(ggstance)
library(skimr)
library(tibble)
library(ggthemes)
library(png)
library(grid)
library(gridExtra)



#Load Data
cdc <- read_delim(file = "data/cdc.txt", delim = "|") %>%
  mutate(genhlth = factor(genhlth,
                          levels = c("excellent", "very good", "good", "fair", "poor"),
                          labels = c("Excellent", "Very Good", "Good", "Fair", "Poor")
  ))

# Set seed
set.seed(8221984)

# Selecting a random subset of size 100
cdc_small <- cdc %>% sample_n(100)

plot_01 <- ggplot(data = cdc_small, aes(x = height, y = weight)) +
  geom_point(size = 3, aes(shape = genhlth, color = genhlth)) +
  scale_y_continuous(
    name = "Weight in Pounds",
    limits = c(100, 300),
    breaks = c(seq(100, 350, 25)),
    trans = "log10",
    labels = scales::unit_format(unit = "lbs")
  ) +
  scale_x_continuous(
    name = "Height in Inches",
    limits = c(55, 80),
    breaks = seq(55, 80, 5),
    labels = scales::unit_format(unit = "in")
  ) +
  scale_shape_manual(
    name = "General\nHealth?",
    labels = c("Excellent", "Very Good", "Good", "Fair", "Poor"),
    values = c(17, 19, 15, 9, 4)
  ) +
  scale_color_brewer(
    name = "General\nHealth?",
    labels = c("Excellent", "Very Good", "Good", "Fair", "Poor"),
    palette = "Set1"
  ) +
  theme(
    legend.position = c(1, 0),
    legend.justification = c(1, 0)
  ) +
  labs(title = "CDC BRFSS: Weight by Height")

#Exercise 1 Plot 1

ggplot(data = cdc_small, aes(x = height, y = weight)) +
  geom_point(size = 3, aes(shape = genhlth, color = genhlth)) +
  scale_y_continuous(
    name = "Weight in Pounds",
    limits = c(100, 300),
    breaks = c(seq(100, 350, 25)),
    trans = "log10",
    labels = scales::unit_format(unit = "lbs")
  ) +
  scale_x_continuous(
    name = "Height in Inches",
    limits = c(55, 80),
    breaks = seq(55, 80, 5),
    labels = scales::unit_format(unit = "in")
  ) +
  scale_shape_manual(
    name = "General\nHealth?",
    labels = c("Excellent", "Very Good", "Good", "Fair", "Poor"),
    values = c(17, 19, 15, 9, 4)
  ) +
  scale_color_brewer(
    name = "General\nHealth?",
    labels = c("Excellent", "Very Good", "Good", "Fair", "Poor"),
    palette = "Set1"
  ) +
  theme(
    legend.position = c(1, 0),
    legend.justification = c(1, 0)
  ) +
  theme_calc() +
  labs(title = "CDC BRFSS: Weight by Height")

#Exercise 1 Plot 2
ggplot(data = cdc_small, aes(x = height, y = weight)) +
  geom_point(size = 3, aes(shape = genhlth, color = genhlth)) +
  scale_y_continuous(
    name = "Weight in Pounds",
    limits = c(100, 300),
    breaks = c(seq(100, 350, 25)),
    trans = "log10",
    labels = scales::unit_format(unit = "lbs")
  ) +
  scale_x_continuous(
    name = "Height in Inches",
    limits = c(55, 80),
    breaks = seq(55, 80, 5),
    labels = scales::unit_format(unit = "in")
  ) +
  scale_shape_manual(
    name = "General\nHealth?",
    labels = c("Excellent", "Very Good", "Good", "Fair", "Poor"),
    values = c(17, 19, 15, 9, 4)
  ) +
  scale_color_brewer(
    name = "General\nHealth?",
    labels = c("Excellent", "Very Good", "Good", "Fair", "Poor"),
    palette = "Set1"
  ) +
  theme(
    legend.position = c(1, 0),
    legend.justification = c(1, 0)
  ) +
  theme_excel() +
  labs(title = "CDC BRFSS: Weight by Height")

#Exercise 1 Plot 3

ggplot(data = cdc_small, aes(x = height, y = weight)) +
  geom_point(size = 3, aes(shape = genhlth, color = genhlth)) +
  scale_y_continuous(
    name = "Weight in Pounds",
    limits = c(100, 300),
    breaks = c(seq(100, 350, 25)),
    trans = "log10",
    labels = scales::unit_format(unit = "lbs")
  ) +
  scale_x_continuous(
    name = "Height in Inches",
    limits = c(55, 80),
    breaks = seq(55, 80, 5),
    labels = scales::unit_format(unit = "in")
  ) +
  scale_shape_manual(
    name = "General\nHealth?",
    labels = c("Excellent", "Very Good", "Good", "Fair", "Poor"),
    values = c(17, 19, 15, 9, 4)
  ) +
  scale_color_brewer(
    name = "General\nHealth?",
    labels = c("Excellent", "Very Good", "Good", "Fair", "Poor"),
    palette = "Set1"
  ) +
  theme(
    legend.position = c(1, 0),
    legend.justification = c(1, 0)
  ) +
  theme_fivethirtyeight() +
  labs(title = "CDC BRFSS: Weight by Height")

#Exercise 1 Plot 4
ggplot(data = cdc_small, aes(x = height, y = weight)) +
  geom_point(size = 3, aes(shape = genhlth, color = genhlth)) +
  scale_y_continuous(
    name = "Weight in Pounds",
    limits = c(100, 300),
    breaks = c(seq(100, 350, 25)),
    trans = "log10",
    labels = scales::unit_format(unit = "lbs")
  ) +
  scale_x_continuous(
    name = "Height in Inches",
    limits = c(55, 80),
    breaks = seq(55, 80, 5),
    labels = scales::unit_format(unit = "in")
  ) +
  scale_shape_manual(
    name = "General\nHealth?",
    labels = c("Excellent", "Very Good", "Good", "Fair", "Poor"),
    values = c(17, 19, 15, 9, 4)
  ) +
  scale_color_brewer(
    name = "General\nHealth?",
    labels = c("Excellent", "Very Good", "Good", "Fair", "Poor"),
    palette = "Set1"
  ) +
  theme(
    legend.position = c(1, 0),
    legend.justification = c(1, 0)
  ) +
  theme_economist() +
  labs(title = "CDC BRFSS: Weight by Height")
#Exercise 1 Plot 5

ggplot(data = cdc_small, aes(x = height, y = weight)) +
  geom_point(size = 3, aes(shape = genhlth, color = genhlth)) +
  scale_y_continuous(
    name = "Weight in Pounds",
    limits = c(100, 300),
    breaks = c(seq(100, 350, 25)),
    trans = "log10",
    labels = scales::unit_format(unit = "lbs")
  ) +
  scale_x_continuous(
    name = "Height in Inches",
    limits = c(55, 80),
    breaks = seq(55, 80, 5),
    labels = scales::unit_format(unit = "in")
  ) +
  scale_shape_manual(
    name = "General\nHealth?",
    labels = c("Excellent", "Very Good", "Good", "Fair", "Poor"),
    values = c(17, 19, 15, 9, 4)
  ) +
  scale_color_brewer(
    name = "General\nHealth?",
    labels = c("Excellent", "Very Good", "Good", "Fair", "Poor"),
    palette = "Set1"
  ) +
  theme(
    legend.position = c(1, 0),
    legend.justification = c(1, 0)
  ) +
  theme_gdocs() +
  labs(title = "CDC BRFSS: Weight by Height")

#Exercise 1 Plot 6

ggplot(data = cdc_small, aes(x = height, y = weight)) +
  geom_point(size = 3, aes(shape = genhlth, color = genhlth)) +
  scale_y_continuous(
    name = "Weight in Pounds",
    limits = c(100, 300),
    breaks = c(seq(100, 350, 25)),
    trans = "log10",
    labels = scales::unit_format(unit = "lbs")
  ) +
  scale_x_continuous(
    name = "Height in Inches",
    limits = c(55, 80),
    breaks = seq(55, 80, 5),
    labels = scales::unit_format(unit = "in")
  ) +
  scale_shape_manual(
    name = "General\nHealth?",
    labels = c("Excellent", "Very Good", "Good", "Fair", "Poor"),
    values = c(17, 19, 15, 9, 4)
  ) +
  scale_color_brewer(
    name = "General\nHealth?",
    labels = c("Excellent", "Very Good", "Good", "Fair", "Poor"),
    palette = "Set1"
  ) +
  theme(
    legend.position = c(1, 0),
    legend.justification = c(1, 0)
  ) +
  theme_map() +
  labs(title = "CDC BRFSS: Weight by Height")

#Exercise 1 Plot 7

ggplot(data = cdc_small, aes(x = height, y = weight)) +
  geom_point(size = 3, aes(shape = genhlth, color = genhlth)) +
  scale_y_continuous(
    name = "Weight in Pounds",
    limits = c(100, 300),
    breaks = c(seq(100, 350, 25)),
    trans = "log10",
    labels = scales::unit_format(unit = "lbs")
  ) +
  scale_x_continuous(
    name = "Height in Inches",
    limits = c(55, 80),
    breaks = seq(55, 80, 5),
    labels = scales::unit_format(unit = "in")
  ) +
  scale_shape_manual(
    name = "General\nHealth?",
    labels = c("Excellent", "Very Good", "Good", "Fair", "Poor"),
    values = c(17, 19, 15, 9, 4)
  ) +
  scale_color_brewer(
    name = "General\nHealth?",
    labels = c("Excellent", "Very Good", "Good", "Fair", "Poor"),
    palette = "Set1"
  ) +
  theme(
    legend.position = c(1, 0),
    legend.justification = c(1, 0)
  ) +
  theme_stata() +
  labs(title = "CDC BRFSS: Weight by Height")

#Exercise 1 Plot 8
ggplot(data = cdc_small, aes(x = height, y = weight)) +
  geom_point(size = 3, aes(shape = genhlth, color = genhlth)) +
  scale_y_continuous(
    name = "Weight in Pounds",
    limits = c(100, 300),
    breaks = c(seq(100, 350, 25)),
    trans = "log10",
    labels = scales::unit_format(unit = "lbs")
  ) +
  scale_x_continuous(
    name = "Height in Inches",
    limits = c(55, 80),
    breaks = seq(55, 80, 5),
    labels = scales::unit_format(unit = "in")
  ) +
  scale_shape_manual(
    name = "General\nHealth?",
    labels = c("Excellent", "Very Good", "Good", "Fair", "Poor"),
    values = c(17, 19, 15, 9, 4)
  ) +
  scale_color_brewer(
    name = "General\nHealth?",
    labels = c("Excellent", "Very Good", "Good", "Fair", "Poor"),
    palette = "Set1"
  ) +
  theme(
    legend.position = c(1, 0),
    legend.justification = c(1, 0)
  ) +
  theme_foundation() +
  labs(title = "CDC BRFSS: Weight by Height")

#Exercise 2
ggplot(data = cdc_small, aes(x = height, y = weight)) +
  geom_point(size = 3, aes(shape = genhlth, color = genhlth)) +
  scale_y_continuous(
    name = "Weight in Pounds",
    limits = c(100, 300),
    breaks = c(seq(100, 350, 25)),
    trans = "log10",
    labels = scales::unit_format(unit = "lbs")
  ) +
  scale_x_continuous(
    name = "Height in Inches",
    limits = c(55, 80),
    breaks = seq(55, 80, 5),
    labels = scales::unit_format(unit = "in")
  ) +
  scale_shape_manual(
    name = "General\nHealth?",
    labels = c("Excellent", "Very Good", "Good", "Fair", "Poor"),
    values = c(17, 19, 15, 9, 4)
  ) +
  scale_color_brewer(
    name = "General\nHealth?",
    labels = c("Excellent", "Very Good", "Good", "Fair", "Poor"),
    palette = "Set1"
  ) +
  theme(
    legend.position = c(1, 0),
    legend.justification = c(1, 0),
    plot.title = element_text(size = 32, face = "bold", color = "yellow", hjust = 3),
    axis.title.x = element_text(size = 4, face = "italic", color = "orange", margin = margin(r = 5)),
    axis.title.y = element_text(size = 8, face = "bold", color = "#ff6ef3", margin = margin(t = 12)),
    panel.grid.major = element_line(color = "#97eb10", size = 3),
    plot.background = element_rect(fill = "red"),
    panel.background = element_rect(fill = "purple")
    
  ) +
  labs(title = "CDC BRFSS: Weight by Height")

#All 8
img1 <- readPNG("img1.png")
grid.raster(img1)

img2 <- readPNG("img2.png")
grid.raster(img2)

img3 <- readPNG("img3.png")
grid.raster(img3)

img4 <- readPNG("img4.png")
grid.raster(img4)

img5 <- readPNG("img5.png")
grid.raster(img5)

img6 <- readPNG("img6.png")
grid.raster(img6)

img7 <- readPNG("img7.png")
grid.raster(img7)

img8 <- readPNG("img8.png")
grid.raster(img8)


img1 <-  grid::rasterGrob(as.raster(readPNG("img1.png")),
                            interpolate = FALSE)
img2 <-  grid::rasterGrob(as.raster(readPNG("img2.png")),
                            interpolate = FALSE)
img3 <-  grid::rasterGrob(as.raster(readPNG("img3.png")),
                          interpolate = FALSE)
img4 <-  grid::rasterGrob(as.raster(readPNG("img4.png")),
                          interpolate = FALSE)
img5 <-  grid::rasterGrob(as.raster(readPNG("img5.png")),
                          interpolate = FALSE)
img6 <-  grid::rasterGrob(as.raster(readPNG("img6.png")),
                          interpolate = FALSE)
img7 <-  grid::rasterGrob(as.raster(readPNG("img7.png")),
                          interpolate = FALSE)
img8 <-  grid::rasterGrob(as.raster(readPNG("img8.png")),
                          interpolate = FALSE)

grid.arrange(img1, img2, img3, img4, img5, img6, img7, img8, ncol = 2, nrow = 4)


#Exercise 3
#Plot 1

ggplot(data = cdc_small, aes(x = height, y = weight)) +
  geom_point(color = "#4E2A84", size = 3) +
  theme(
    panel.background = element_rect(fill = "white", color = "#716C6B"),
    plot.background = element_rect(fill = "white", color = "#716C6B"),
    panel.grid.major = element_line(color = "black", linetype = "dotted"),
    axis.title.x = element_text(family = "Georgia", size = 16),
    axis.title.y = element_text(family = "Georgia", size = 16),
    plot.title = element_text(family = "Georgia")
    
    
  ) +
  xlab("Height (in.)") +
  ylab("Weight (lbs)") +
  ggtitle("Height vs. Weight")

#Plot 2
ggplot (data = cdc_small, aes (height)) +
  geom_bar(fill = "#4E2A84") +
  theme(
    panel.background = element_rect(fill = "white", color = "#716C6B"),
    plot.background = element_rect(fill = "white", color = "#716C6B"),
    panel.grid.major = element_line(color = "black", linetype = "dotted"),
    axis.title.x = element_text(family = "Georgia", size = 16),
    axis.title.y = element_text(family = "Georgia", size = 16),
    plot.title = element_text(family = "Georgia")
    
    
  ) +
  xlab("Height (in.)") +
  ylab("Count") +
  ggtitle("Height of Pop.")



