#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Бриллианты"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          
            selectInput('ucolor', 'choose a color:',
                         choices = c('Pink' = 'pink', 
                                     'Sky-blue' = 'skyblue', 
                                     'Light-green' = 'lightgreen',
                                     'Light-yellow'='lightyellow'))
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- diamonds$cut

        # draw the histogram with the specified number of bins
        barplot(table(x), 
                col = input$ucolor, 
                border = 'white',
                main = 'Распределение огранки бриллиантов',
                xlab = 'Вид огранки',
                ylab = 'Кол-во')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
