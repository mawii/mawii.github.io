library(shiny)

shinyServer(function(input, output) {
    model1 <- lm(Temp ~ Ozone, data = airquality)
    model2 <- lm(Temp ~ Wind, data = airquality)
    
    model1pred <- reactive({
        OzoneInput <- input$sliderOzone
        predict(model1, newdata = data.frame(Ozone = OzoneInput))
    })
    
    model2pred <- reactive({
        WindInput <- input$sliderWind
        predict(model2, newdata = data.frame(Wind = WindInput))
    })
    
    output$plot1 <- renderPlot({
        OzoneInput <- input$sliderOzone
        WindInput <- input$sliderWind
        
        par(mfrow = c(1, 2))
        # Model 1
        if(input$showModel1) {
            plot(airquality$Ozone, airquality$Temp, xlab = "Ozone Concentration (ppb)",
                 ylab = "Temperature (degrees F)", bty = "n", pch = 16,
                 xlim = c(1, 170), ylim = c(0, 110))
            abline(model1, col = "red", lwd = 2)
            points(OzoneInput, model1pred(), col = "red", pch = 16, cex = 2)
            legend(25, 40, "Model 1 Prediction", pch = 16,
                   col = "red", bty = "n", cex = 1.2)
        }
        #Model 2
        if(input$showModel2) {
            plot(airquality$Wind, airquality$Temp, xlab = "Wind Speed (mph)",
                 ylab = "Temperature (degrees F)", bty = "n", pch = 16,
                 xlim = c(1, 22), ylim = c(0, 110))
            abline(model2, col = "blue", lwd = 2)
            points(WindInput, model2pred(), col = "blue", pch = 16, cex = 2)
            legend(5, 40, "Model 2 Prediction", pch = 16,
                   col = "blue", bty = "n", cex = 1.2)
        }
        
    })
    
    output$pred1 <- renderText({
        model1pred()
    })
    
    output$pred2 <- renderText({
        model2pred()
    })
    
})
