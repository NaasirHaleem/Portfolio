#Load in Packages
library(shiny)
library(tidyverse)


#Read in data + prep
source("final_scope.R")
source("helper.R")

#Actual App Running

ui <- fluidPage(
  
  # App title ----
  titlePanel("Northwestern Football: Rushing and Passing Performances in 2012/2013"),
  
  sidebarLayout(
    position = "right",
    # Sidebar panel for inputs ----
    sidebarPanel(
      #Drop Down for Rushing/Passing
      selectInput(
        inputId = "var",
        label = "Yards or Attempts",
        choices = list("Yards" = "yard",
                       "Attempts" = "attempts",
        selected = "Yards")),
      
      
      
      #Yearly Dropdown
      selectInput(
        inputId = "year_var",
        label = "Year",
        choices = list("2012",
                       "2013",
                       selected = "2012")
        
        #Drop Down for Rushing/Passing Attempts
        #selectInput(
          #inputId = "x_var",
          #label = "Passing Attempts/Rushing Attempts",
          #choices = list("pass_att",
                         #"rush_att",
                         #selected = "pass_att"))
      
    ),
    p("Source for statistics via Kaggle:
      https://www.kaggle.com/mhixon/college-football-statistics"),
    p("Source for injuries via Chicago Tribune and Inside NU"),
    h1("2012 Season"),
    p("Game 1: at Syracuse W 42-41"),
       p("Game 2: Vanderbilt W 23-13"),
       p("Game 3: Boston College W 22-13"),
       p("Game 4: South Dakota W 38-7"),
       p("Game 5: Indiana W 44-29"),
       p("Game 6: at Penn State L 28-39"),
       p("Game 7: at Minnesota W 21-13"),
       p("Game 8: Nebraska L 28-29"),
       p("Game 9: Iowa W 28-17"),
       p("Game 10: at Michigan L 31-38 OT"),
       p("Game 11: at Michigan State W 23-20"),
       p("Game 12: Illinois W 50-14"),
       p("Game 13: Mississippi State 34-20"),
    h1("2013 Season"),
    p("Game 1: at Cal W 44-30"),
    p("Game 2: Syracuse W 48-27"),
    p("Game 3: Western Michigan W 38-17"),
    p("Game 4: Maine W 35-21"),
    p("Game 5: Ohio State L 30-40"),
    p("Game 6: at Wisconsin L 6-35"),
    p("Game 7: Minnesota L 17-20"),
    p("Game 8: at Iowa L 10-17"),
    p("Game 9: at Nebraska L 24-27"),
    p("Game 10: Michigan L 19-27 3OT"),
    p("Game 11: Michigan State L 6-30"),
    p("Game 12: at Illinois W 37-34"),
    p("Injury Notes: Venric Mark (RB) out for season after Game 6"),
    p("Stephen Buckley (RB) out for season after Game 9")),
      
    
    
      
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      plotOutput(outputId = "distPlot")
      
    )))
  

server <- function(input, output) {
  output$distPlot <- renderPlot({
   
    #Button to switch between years
    output$value <- renderPrint({ input$select })
    
    #northwestern_football %>% 
      #filter(year == input$year_var) %>% 
      #ggplot(aes_string('game_number', input$x_var)) +
      #geom_point() +
      #geom_line()
    graph(northwestern_football, input$var, input$year_var)
    

    
  })}
    

shinyApp(ui = ui, server = server)