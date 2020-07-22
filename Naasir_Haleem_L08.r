# Load package(s)
library(tidyverse)
library(ggplot2)
library(ggstance)
library(skimr)
library(tibble)
library(cowplot)



# Load datasets
load("data/titanic.rda")
load ("data/Aus_athletes.rda")


# Read in the cdc dataset
cdc <- read_delim(file = "data/cdc.txt", delim = "|") %>%
  mutate(
    genhlth = factor(
      genhlth,
      levels = c("excellent", "very good", "good", "fair", "poor"),
      labels = c("Excellent", "Very Good", "Good", "Fair", "Poor")
    ),
    genhlth = fct_rev(genhlth),
    gender = factor(
      gender,
      levels = c("f", "m"),
      labels = c("Women", "Men")
    ),
    wgt_change = wtdesire - weight
  )

# Set seed
set.seed(8221984)

# Selecting a random subset of size 1000
cdc_small <- cdc %>% sample_n(1000)




### Exercise 1

titanic %>%
  mutate(surv = ifelse(survived ==1, "survived", "died")) %>%
  ggplot(aes(sex, fill = sex)) +
  geom_bar() +
  facet_grid(surv ~ class) +
  scale_x_discrete(NULL) +
  scale_fill_manual(values = c("#D55E00D0", "#0072B2D0"), guide = "none") +
  theme_minimal()



#Exercise 2
# Get list of sports played by BOTH sexes
both_sports <- Aus_athletes %>%
  distinct(sex, sport) %>%
  count(sport) %>%
  filter(n == 2) %>%
  pull(sport)

# Process data
athletes_dat <- Aus_athletes %>%
  filter(sport %in% both_sports) %>%
  mutate(sport = case_when(
    sport == "track (400m)" ~ "track",
    sport == "track (sprint)" ~ "track",
    TRUE ~ sport
  ))

#Plot 1
plot_01<- ggplot(athletes_dat, aes(sex, fill = sex)) +
  geom_bar() +
  scale_x_discrete(NULL, labels = c("female","male")) +
  scale_y_continuous("number", limits = c(0,95), expand = c(0,0)) +
  scale_fill_manual(values = c("#D55E00D0","#0072B2D0"), guide = "none") +
  theme_minimal()

#Plot 2
plot_02 <- ggplot(athletes_dat, aes(rcc,wcc, fill = sex)) +
  geom_point(size = 3, shape = 21, color = "white") +
  scale_fill_manual(values = c("#D55E00D0","#0072B2D0"), guide = "none") +
  labs(
    x = "RBC count",
    y = "WBC count"
  ) +
  theme_minimal()

#Plot 3
plot_03 <- ggplot(athletes_dat, aes(sport, pcBfat, color = sex, fill = sex)) +
  geom_boxplot(width = 0.5) +
  scale_color_manual(NULL, values = c("#D55E00","#0072B2D0"), guide = "none",
                     labels = c("female", "male")) +
  scale_fill_manual(NULL, values = c("#D55E0040","#0072B240"), guide = FALSE) +
  theme_minimal()+
  theme(legend.justification = c(1,1), legend.position = c(1,1), legend.direction = "horizontal") +
  guides(color = guide_legend(override.aes = list(color = NA, fill = c("#D55E0040", "#0072B240")))) +
  labs(x = NULL, y = "number")

#combined

top_row <- cowplot::plot_grid(plot_01, plot_02, align = "h")
cowplot::plot_grid(top_row, plot_03, ncol = 1)


#Plot 4

shadow_points <- cdc_small %>% select(-gender) 

ggplot(data = cdc_small, mapping = aes(weight,wgt_change, color = gender)) +
  geom_point(data = shadow_points, color = "grey80", size = 2) +
  geom_point(data = cdc_small, aes(color = gender), size =2) +
  facet_grid(gender~genhlth) +
  theme_minimal() +
  scale_x_continuous("Weight (lbs)", breaks = seq(100,300,100)) +
  scale_y_continuous("Weight loss/Gain in Pounds\n(+ to gain, - to lose)") +
  scale_color_manual(values = c('#D55E00D0', '#0072B2D0' ), guide = FALSE)

ggplot(data = cdc_small,aes(weight,wgt_change, color = gender)) +
  geom_point(data = shadow_points, color = "grey80", size = 2) +
  geom_point(size =2) +
  facet_grid(vars(gender), vars(genhlth)) +
  theme_minimal()
  
  
  
  
  
  
  
  
  
  

         
         
       




