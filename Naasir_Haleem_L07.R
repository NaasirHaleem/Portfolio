# Load package(s)
library(tidyverse)
library(ggplot2)
library(ggstance)
library(skimr)
# Load datasets
load("data/tech_stocks.rda")

# Read in the cdc dataset
cdc <- read_delim(file = "data/cdc.txt", delim = "|") %>%
  mutate(genhlth = factor(genhlth,
                          levels = c("excellent", "very good", "good", "fair", "poor")
  ))

# Set seed
set.seed(8221984)

# Selecting a random subset of size 100
cdc_small <- cdc %>% sample_n(100)

# Generating toy datasets for exercise 2
dat1 <- tibble(theta = seq(0, 2 * pi, 0.01))

dat2 <- tibble(
  theta = seq(0, 2 * pi, length.out = 100),
  obs = rnorm(100, sin(theta), 0.1),
  larger_than = ifelse(abs(obs) < abs(sin(theta)), "1", "0")
)

#Exercise 1

ggplot(data = tech_stocks, aes(date, price_indexed)) +
  geom_line(aes(color = company)) +
  scale_y_continuous(position = "right",breaks = c(0,100,200,300,400,500), labels = c("0","$100", "$200", "$300", "$400", "$500")) +
  theme_minimal() +
  theme (legend.position = c(.75,.85)) +
  scale_color_discrete(limits = c("Facebook", "Alphabet", "Microsoft", "Apple")) +
  scale_x_date(expand=c(0,0)) +
  labs(
    x=NULL,
    y=NULL,
    color = NULL) +
  ggtitle("Stock price, indexed") +
  guides(color =guide_legend(override.aes = list(size = 1.3)))


#Exercise 2

ggplot(data = dat2, aes(theta)) +
  geom_point(aes(y = obs, color = larger_than), show.legend=FALSE, size = 2) +
  stat_function(data = dat1, aes(y=NULL),fun = sin, size = 1.3, alpha =0.8, color = "#56B4E9") +
  labs(x = quote(theta), y = quote(sin(theta))) +
  scale_color_manual(values = c("darkgreen", "red")) +
  theme_minimal()
  

#Exercise 3
cdc_small <- cdc %>% sample_n(100)

ggplot(data = cdc_small, aes(height, weight, color = genhlth, shape = genhlth)) +
  geom_point(size = 3) +
  theme(legend.position = c(1,0), legend.justification = c(1,0)) +
  scale_color_brewer("General\n Health?" ,palette = "Set1",
                     labels = c("Excellent", "Very Good", "Good", "Fair", "Poor"),
                     limits = c("excellent" , "very good", "good", "fair", "poor")) +
  scale_x_continuous(NULL, breaks = seq(55,80,5), limits = c(55,80), labels = scales::unit_format(unit = "in")) +
  scale_y_continuous(NULL, limits = c(100,300), breaks = seq(100,300,25),
                     trans = "log10", labels = scales::unit_format(unit = "lbs")) +
  scale_shape_manual("General\n Health?", values = c(17,19,15,9,4),
                     labels = c("Excellent", "Very Good", "Good", "Fair", "Poor"),
                     limits = c("excellent" , "very good", "good", "fair", "poor")) +
  labs(title = "CDC BRFSS: Weight by Height") +
  theme_minimal()
  
  

  

  
  
  

