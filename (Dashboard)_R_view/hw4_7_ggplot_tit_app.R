
library(shiny)
library(tidyverse)
tit <- read.csv('Titanic.csv')
tit <- tit %>% mutate(Survived = if_else(Survived == 1, 'Survived', 'Died'))

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Titanic Passengers"),

    # Row with a sliders input for qualitative and quantitative indicators
    fluidRow(
      column(4, selectInput('qualit', 'Barplot:', choices = c('Survived', 'Pclass', 'Sex'))),
      column(4, selectInput('quant', 'Histogram:', choices = c('Age', 'Fare')))
      ),
    
    # Row with a sliders input for colors
    fluidRow(
      column(4, selectInput('col1', 'Bar color', choices = c('Red' = 'lightcoral',
                                                              'Blue' = 'skyblue',
                                                              'Yellow' = 'navajowhite2'))),
      
      column(4, selectInput('col2', 'Hist color', choices = c('Green' = 'olivedrab3',
                                                             'Pink' = 'pink2',
                                                             'Grey'='slategray1')))
    ),
        

    # Show a plots of the generated distributions
    mainPanel(
      fluidRow(
        splitLayout(cellWidths = c('50%', '50%'), plotOutput('distPlot1'), plotOutput('distPlot2'))))
)


# Define server logic required to draw a histogram
server <- function(input, output) {
    # draw the bars with the specified colors and value
    output$distPlot1 <- renderPlot({
      
      qualit <- tit[, input$qualit]
      
      ggplot(data = tit) +
        geom_bar(aes(x = qualit),
                 color = 'white',
                 fill = input$col1) +
        labs(x = input$qualit, y = 'Count') +
        theme_minimal()
 
    })
    
    # draw the histogram with the specified colors and value
    output$distPlot2 <- renderPlot({
      
      quant = tit[, input$quant]
      
      ggplot(data = tit) +
        geom_histogram(aes(x = quant),
                       color = 'white',
                       fill = input$col2) +
        labs(x = input$quant, y = 'Count') +
        theme_minimal()
      
    })
}


# Run the application 
shinyApp(ui = ui, server = server)
