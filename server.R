library(shiny)

shinyServer(
  function(input, output) {
    
    colm<-reactive({
        as.numeric(input$var)
        
        
    })  
      
      
    output$sum<-renderPrint({
          summary(iris)
      })   
      
      
      
    output$str<-renderPrint({
    str(iris)
    }) 
      
    output$data<-renderTable({
    iris[colm()] 
   
       
       
   })  
      
    output$myhist<-renderPlot({
    
    hist(iris[,colm()],breaks=seq(0,max(iris[,colm()]),l=input$bins+1),
    col=input$color,main="Histogram of Iris Dataset",xlab=names(iris[colm()]))
    
    
  })
    
    output$docum <- renderText({
        
        paste0("<h3><b>Purpose of the app </b></h3>",
               "I created a shiny app with different tabsets panel showing the following features : 
               1) the summary of the iris dataset; 
               2) the structure of the iris dataset;
               3) a possible filter of one of the iris columns; 
               4) the histogram of the iris dataset",
               "<h3><b>How to use the ui.R </h3></b></h3>",
               "There are 3 main input to select:
               1)The variable from the iris dataset; 
               2)The number of bins for histogram as a slider input that a user can manipulate;
               3)the histrogram colour as a radioButton Input ",
               "<h3><b>  How server.R works </h3></b></h3>",
               "In the server.R file I created a reactive expression in order to provide reactivity to how  the input change "
              
        )
    })
    
    
  }
)








