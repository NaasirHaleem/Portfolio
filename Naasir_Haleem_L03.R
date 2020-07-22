#Lab 3


```{r load-packages, warning=FALSE, message=FALSE}
library(tidyverse)
library(ggstance)
library(skimr)
library (lubridate)
library (mgcv)
library (splines)
library (colorspace)

```{r}
load("~/Desktop/Stats_302/data_vis_labs/data/BA_degrees.rda")
```

#Exercise 1
```{r, eval = FALSE}
# Wrangling for plotting
ba_dat <- BA_degrees %>%
  # mean % per field
  group_by(field) %>% 
  mutate(mean_perc = mean(perc)) %>% 
  # Only fields with mean >= 5%
  filter(mean_perc >= 0.05) %>%
  # Organizing for plotting
  arrange(desc(mean_perc), year) %>% 
  ungroup() %>% 
  mutate(field = fct_inorder(field))
```
#Plot 1

ggplot(data = ba_dat,
       mapping = aes(year,perc)) +
  geom_line () + 
  facet_wrap(~field) +
  labs(x= "Year",
       y = "Proportion of Degrees") +
  theme_minimal() 

#Plot 2

ggplot(data = ba_dat,
       mapping = aes(year, perc)) +
  geom_area(fill = "red", alpha = 0.5) +
  geom_line (color = "red") + 
  facet_wrap(~field) +
  labs(x= "Year",
       y = "Proportion of Degrees") +
  theme_minimal() 

#Plot 3

ggplot(data = ba_dat,
       mapping = aes(year, perc)) +
  geom_line(aes(color = field))  +
  labs(x= "Year",
       y = "Proportion of Degrees") +
  theme_minimal() 

#Exercise 2
load("~/Desktop/Stats_302/data_vis_labs/data/dow_jones_industrial.rda")

djia_date_range <- dow_jones_industrial %>% 
  filter(date >= ymd("2008/12/31") & date <= ymd("2010/01/10")) 

#Plot 1
```{r, eval = False}

djia_date_range%>%
ggplot(data = djia_date_range, mapping = aes(date, close)) +
  geom_line(color = "purple") +
  geom_smooth(color = "green") +
  theme_minimal() 

#Plot 2
ggplot(data = djia_date_range, mapping = aes(date, close)) +
  geom_line() +
  geom_smooth(span = 0.3) +
  theme_minimal()

#Plot 3
ggplot(data = djia_date_range, mapping = aes(date, close)) +
  geom_line() +
  geom_smooth(method = "gam",formula =  y ~ s(x, bs = "cs"), color = "blue") 

#Exercise 3

#Plot 1

cdc <- read_delim(file = "~/Desktop/Stats_302/data_vis_labs/data/cdc.txt", delim = "|") %>%
  mutate(genhlth = factor(genhlth,
                          levels = c("excellent", "very good", "good", "fair", "poor")
  ))

#genhlth_count <- cdc %>%
  #count(genhlth)

#hlth_plan <- cdc %>%
  count(hlthplan)

ggplot(cdc, aes(genhlth)) + 
  geom_bar()

ggplot(genhlth_count, aes(genhlth)) + geom_bar()

#Plot 2

ggplot(data = cdc, aes(genhlth)) +
  geom_bar (aes (color = hlthplan))

#Plot 3

ggplot (data = cdc, aes(weight, color = "#330000")) +
  geom_density(aes(fill = genhlth)) +
  facet_wrap(~gender)

#Plot 4

ggplot (data = cdc, aes(weight)) +
  geom_density(aes(fill = gender, alpha=0.2)) +
  facet_wrap(~genhlth) 

#Plot 5
ggplot (data = cdc, aes(gender, height)) +
  geom_boxplot(aes(fill = gender, transparency=0.2)) +
  facet_wrap(~genhlth)


#Plot 6
ggplot (data = cdc, aes(height, weight)) +
  geom_point(aes(color=gender)) +
  geom_smooth(aes(color=gender, alpha=0.2),method = "lm")

rgb(0.2,0,0)




         





