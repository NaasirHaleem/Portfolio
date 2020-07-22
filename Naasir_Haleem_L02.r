#Birds and Stuff

#Exercise 1
```{r load-packages, warning=FALSE, message=FALSE}
# Set the seed for reproducibility
set.seed(31412718)

# Load package(s)

```{r load-packages, warning=FALSE, message=FALSE}
library(tidyverse)
library(ggstance)
library(skimr)
``

``{r}
load("~/Desktop/Stats_302/data_vis_labs/data/blue_jays.rda")
``
#Inspect Data

glimpse (blue_jays)

skim (blue_jays)

view(blue_jays)



#Exercise 1
#1.1
``{r}
ggplot(data=blue_jays, aes(Head, Mass)) +
  geom_point(color= "#4E2A84", shape = 17, size = 2)

bird <- blue_jays %>%
``
#1.2
``{r}
ggplot(data = blue_jays) +
  geom_point(mapping = aes(x=Head, y= Mass, color= KnownSex), size =2) 

#Using KnownSex is more appropriate because it differentiates by sex and labels them "Male"
#and "Female" accordingly. Sex labels the blue jays by 1 or 0 which is not helpful.

#1.3

#The two usages are different because if I used the function:

#ggplot(data=blue_jays, aes(Head, Mass)) +
  #geom_point(color= "#4E2A84", shape = 17, size = 2)

 #This would convey that I just want the graphed points to be a specific color, in this case
#Northwestern Purple.

#However if I used the function:

#ggplot(data = blue_jays) +
  #geom_point(mapping = aes(x=Head, y= Mass, color= KnownSex), size =2) 

#This conveys that I'm purposefully using color in order to separate two different values.
#In this case that would be separating out "Males" from "Females."

#Exercise 2

```{r cdc-small, warning=FALSE, message=FALSE}
# Read in the cdc dataset
cdc <- read_delim(file = "~/Desktop/Stats_302/data_vis_labs/data/cdc.txt", delim = "|") %>%
  mutate(genhlth = factor(genhlth,
                          levels = c("excellent", "very good", "good", "fair", "poor")
  ))

# Selecting a random subset of size 100
cdc_small <- cdc %>% sample_n(100)
```
#1
ggplot(data = cdc_small, aes(weight,height)) +
  geom_point(mapping = aes(x=weight, y= height))

#2
ggplot (data = cdc_small, aes(weight,height)) +
  geom_point(color = "blue")

#3
ggplot (data=cdc_small, aes(weight,height)) +
  geom_point (shape = 15)

#4
ggplot (data=cdc_small, aes(weight,height)) +
  geom_point (size = 4)

#5
ggplot (data=cdc_small, aes(weight,height)) +
  geom_point (color = "purple", shape = 14)
#6

ggplot (data=cdc_small, aes(weight,height)) +
  geom_point (color = "purple", shape = 2, size= 3)
  

  


``




