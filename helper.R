graph <- function(data, variable,year_var){
  plot.new()
  if(variable == "yard"){ 
    data = data %>% 
      select(yards, game_number,year,yard_type)
    #Want to establish within the app that it's not possible to choose both yard type and attempt type so have to make an if statement here
    data %>% 
      filter(year == year_var) %>%
      ggplot(aes(game_number, yards, color = yard_type)) +
      geom_line() +
      scale_x_continuous("Game Number", breaks = seq(1,13)) +
      scale_color_manual("Yards", values = c("purple","black"), labels = c("Pass Yards", "Rush Yards")) +
      xlab("Game Number") +
      ylab("Yards") +
      theme_minimal()
    
    }
  else{
    data = data %>%
      select(attempts, att_type, game_number,year)
    
  #Thus associate each button output with a specific graph that is generated
  data %>% 
    filter(year == year_var) %>%
    ggplot(aes(game_number, attempts)) +
    geom_col(aes(fill = att_type),position = "fill") +
    scale_fill_manual("Attempt Type", labels = c("Pass Attempts", "Rush Attempts"), values = c('purple','grey')) +
    ylab("Attempts(Percentage)") +
    scale_x_continuous("Game Number", breaks = seq(1,13)) +
    labs(title = "Ratio of Pass Attempts Vs. Rush Attempts") +
    theme_minimal() +
    theme(
      panel.background = element_blank(),
      plot.background = element_blank(),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank()
    ) 
  }
}

graph(northwestern_football, variable = "attempts", year_var = "2012")

graph(northwestern_football, variable = "yard", year_var = "2012")
