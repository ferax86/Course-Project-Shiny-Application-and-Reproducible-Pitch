db <- read.csv("Dataset_Football.csv", sep=";")
db$Price<-as.numeric(db$Price)
db$Price<-db$Price/1000000
db$Age<-as.integer(db$Age)
# db$Age_Adj<-ifelse(db$Score - mean(db$Score) > 0,db$Age-5,db$Age)
library(shiny)
summary(db)
shinyServer(function(input, output) {
  db$Age_Adj<-ifelse(db$Score - mean(db$Score) > 0,db$Age-5,db$Age)
  model1 <- lm(Price ~ Score, data = db)
  model2 <- lm(Price ~ Score + Age_Adj, data = db)
  
  model1pred <- reactive({
    Scoreinput <- input$sliderscore
    predict(model1, newdata = data.frame(Score = Scoreinput))
  })
  
  model2pred <- reactive({
    Scoreinput <- input$sliderscore
    predict(model2, newdata =
              data.frame(Score = Scoreinput,
                         Age_Adj = ifelse(Scoreinput - mean(db$Score)  > 0, db$Age-5, db$Age)))
                                           
                                                 
  })

  
  output$plot1 <- renderPlot({
      Scoreinput <- input$sliderscore
    
    plot(db$Score, db$Price, xlab = "Overall score",
         ylab = "Price (Millions)", bty = "n", pch = 16,
         xlim = c(10, 40), ylim = c(10, 100))
    if(input$showModel1){
      abline(model1, col = "red", lwd = 2)
    }
    if(input$showModel2){
      Scores<-seq(10,35,length=41)
      model2lines <- predict(model2, newdata = data.frame(
      Score = Scores, Age_Adj = ifelse(Scores- mean(db$Score) > 0, db$Age-5, db$Age)))
      lines(Scores, model2lines, col = "blue", lwd = 2)
    }
    
    
    legend(25, 35, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16,
           col = c("red", "blue"), bty = "n", cex = 1.2)
    points(Scoreinput, model1pred(), col = "red", pch = 16, cex = 2)  #here we see the benefit of model1pred() reactivity: we have to use the () to retrieve the number   and not the function
    points(Scoreinput, model2pred(), col = "blue", pch = 16, cex = 2) #here we see the benefit of model2pred() reactivity
  })
  
  output$pred1 <- renderText({
    model1pred()
  })
  
  output$pred2 <- renderText({
    model2pred()
  })
})


# Age_Adj <- ifelse(Scoreinput - mean(db$Score) > 0, db$Age-5, db$Age)
# set.seed(2)
# sample(10:40,27,replace = TRUE)

