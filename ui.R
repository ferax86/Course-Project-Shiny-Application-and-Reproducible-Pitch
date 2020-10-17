setwd("C:/Users/lenovo/Desktop/COURSERA/DATA SCIENCE-COURSERA/MODULE 9 - Developing Data Products/WEEK 4")
options(scipen = 999)  
# db <- read.csv("Dataset_Football.csv", sep=";")
# db$Price<-as.numeric(db$Price)
# db$Price<-db$Price/1000000
# db$Age<-as.integer(db$Age)
# db$Age_Adj<-ifelse(db$Score - mean(db$Score) > 0,db$Age-5,db$Age)

library(shiny)
shinyUI(fluidPage(
  titlePanel("Predict Price Fottballer  from overall score"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderscore", "What is the score the footballer?", 10, 40, value = 20),
      checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
      checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
      submitButton("Submit") 
      
    ),
    mainPanel(
      plotOutput("plot1"),
      h3("Predicted price from Model 1:"),
      textOutput("pred1"),
      h3("Predicted price from Model 2:"),
      textOutput("pred2")
    )
  )
))
