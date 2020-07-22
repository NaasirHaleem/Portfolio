#Load Packages
library (tidyverse)
library (ggplot2)
library (ggstance)
library (skimr)
library (datasets)

#Load Datasets
cdc <- read_delim(file = "data/cdc.txt", delim = "|") %>%
  mutate(genhlth = factor(genhlth,
                          levels = c("excellent", "very good", "good", "fair", "poor")))

###

load("data/cows.rda")
load("data/tech_stocks.rda")


##set seed
set.seed(9876)


##Exercise 1

#Plot 1


# Additional dataset for plot
class_dat <- mpg %>%
  group_by(class) %>%
  summarise(n = n(), 
            hwy = mean(hwy),
            label = str_c("n = ", n, sep = ""))

ggplot(data = mpg, aes(class, hwy)) +
  geom_jitter(width = 0.1) +
  geom_point(data = class_dat, color = "red", alpha = 0.6, size = 5)  +
  ylim(c(10, 45)) +
  geom_text(data = class_dat, aes(y = 10, label = label)) +
  theme_minimal() +
  labs(
    x = "Vehicle class",
    y = "Highway miles per gallon"
  )

 



#Plot 2

# Graphic dataset
cow_means <- cows %>% 
  filter(breed != "Canadian") %>%
  group_by(breed) %>%
  summarize(
    mean = mean(butterfat),
    se = sd(butterfat)/sqrt(n())
  ) %>%
  mutate(breed = fct_reorder(factor(breed), desc(mean)))

ggplot (data = cow_means, aes(breed, mean)) +
  geom_col(color = "#56B4E9", fill = "#56B4E9", width = .7) +
  geom_errorbar(aes(ymin = mean - qnorm(.975)*se, ymax = mean +qnorm(.975)*se), 
                width =0.1) +
  labs(
    x = "Cattle breed",
    y = "Mean percent butterfat
    content in milk"
  ) +
  theme_minimal() 

  
  
#Exercise 3
  
perc_increase <- tech_stocks %>% 
  ungroup(ticker) %>% 
  arrange(desc(date)) %>% 
  distinct(company, .keep_all = TRUE) %>% 
  mutate(perc = 100 * (price - index_price) / index_price,
         label = str_c(round(perc), "%", sep=""),
         company = fct_reorder(factor(company), perc)) 
#Plot

ggplot(data = perc_increase, aes(perc, company)) +
  geom_colh(fill = "#56B4E9") +
  geom_text(data = perc_increase, aes (label = label), color = "white", nudge_x = -24, size = 5) +
  labs ( x= "",
         y= "") +
  theme_minimal()


       
       

       
#Exercise 4

cdc_weight_95ci <- cdc %>% 
  group_by(genhlth, gender) %>% 
  summarise(mean_wt = mean(weight),
            se = sd(weight) / sqrt(n()),
            moe = qt(0.975, n() - 1) * se)

ggplot(data = cdc_weight_95ci, aes(x = gender, y = mean_wt, color = genhlth )) +
  geom_errorbar(aes(ymin = mean_wt - moe, ymax = mean_wt + moe), width = 0.1, position =
                position_dodge(width = 0.5)) +
  geom_point(position = position_dodge(width = 0.5)) + 
  coord_flip() +
  labs (
    x="Gender",
    y="Weight (lbs)",
    color = "General health
(self reported)"
    
    )  +
  theme_minimal()

 
  
  

