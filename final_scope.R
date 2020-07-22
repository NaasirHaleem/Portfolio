#Create app that illustrates the performance of the Northwestern Football teams passing and rushing performance across
#two seasons, 2012 and 2013. In this app should also record injuries to key players (runningbacks, quarterbacks) to possibly
#explain any irregularities. Should be a button that switches between seasons, one that switches between rushing and passing,
#and a graph that tracks yards per game. Might also be a third graph that measures both seasons side by side.
#Northwestern Team Code = 509
library(tidyverse)
library(stringr)
library(janitor)
plot.new()

northwestern2012 <- read_csv("finaldata/2012team-game-statistics.csv") %>%  
  clean_names() %>% 
  filter(team_code == "509") %>% 
  mutate(game_number = row_number(),
         year = "2012")

northwestern2013 <- read_csv("finaldata/2013team-game-statistics.csv") %>% 
  clean_names() %>% 
  filter(team_code == "509") %>% 
  mutate(game_number = row_number(),
         year = "2013")

#We want to gather the different types of yard types and offensive play types so that we can analyze the,
northwestern_football <- bind_rows(northwestern2012, northwestern2013) %>% 
  gather(key = att_type, value = attempts, rush_att, pass_att) %>% 
  gather(key = yard_type, value = yards, rush_yard, pass_yard)


northwestern_football %>% 
  filter(year == "2013") %>%
  ggplot(aes(game_number, attempts, fill = att_type)) +
  geom_col(position = "fill") +
  scale_fill_manual("Attempt Type", labels = c("Pass Attempts", "Rush Attempts"), values = c('purple','grey')) +
  xlab("Game Number") +
  ylab("Attempts(Percentage)") +
  theme_minimal() +
  theme(
    panel.background = element_blank(),
    plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  ) 

northwestern_football %>% 
  filter(year == "2012") %>%
  ggplot(aes(game_number, attempts, fill = att_type)) +
  geom_col(position = "fill") +
  scale_fill_manual("Attempt Type", labels = c("Pass Attempts", "Rush Attempts"), values = c('purple','grey')) +
  xlab("Game Number") +
  ylab("Attempts(Percentage)") +
  theme_minimal() +
  theme(
    panel.background = element_blank(),
    plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  ) 


ggplot(northwestern_football, aes(game_number, pass_yard)) +
  geom_line(aes(color = year, group = year)) 



  








