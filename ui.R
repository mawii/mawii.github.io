library(shiny)

# Define UI for application that predicts temperature from ozone concentration and
# wind speed
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Predict Temperature from Ozone Concentration and Wind Speed"),
    
    
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderOzone",
                        "What is the Ozone Concentration (ppb)?",
                        min = 1,
                        max = 170,
                        value = 100),
            sliderInput("sliderWind",
                        "What is the Wind Speed (mph)?",
                        min = 1,
                        max = 22,
                        value = 14),
            checkboxInput("showModel1", "Show/Hide Model 1", value = T),
            checkboxInput("showModel2", "Show/Hide Model 2", value = T),
            submitButton("Submit") # delayed reactivity
        ),
        
        
        mainPanel(
            plotOutput("plot1"),
            h3("Predicted Temperature from Model 1:"),
            textOutput("pred1"),
            h3("Predicted Temperature from Model 2:"),
            textOutput("pred2")
        )
    )
))
