library(shiny)

shinyServer(function(input, output) {
  
  # Generate a plot of the data. Also uses the inputs to build
  # the plot label. Note that the dependencies on both the inputs
  # and the data reactive expression are both tracked, and
  # all expressions are called in the sequence implied by the
  # dependency graph
  output$plot <- renderPlot({
    i <- as.numeric(input$dist)
    mycol<-as.numeric(input$col)
    myname=colnames(mtcars)[i]
    out=lm(mtcars$mpg~mtcars[,as.numeric(i)])
    if((i==2)|(i>=8)){
        boxplot(mtcars$mpg~mtcars[[myname]],xlab=myname,ylab="mpg",col=5:10)
    }
    else{
        if(mycol==2){  
          plot(mtcars$mpg~mtcars[[myname]],xlab=myname,ylab="mpg",col=mtcars$cyl/2)
          if(input$legend) legend("topright",legend=c("4","6","8"),
                 title="Cylinders",pch=1,col=mtcars$cyl/2)
        }
        else {
          plot(mtcars$mpg~mtcars[[myname]],xlab=myname,ylab="mpg",col=mtcars$am+1)
          if(input$legend) legend("topright",legend=c("automatic","manual"),
                 title="Transmission",pch=1,col=1:2)
        } 
        if(input$choice) abline(out,col="blue")
        if(input$equation) {
            myequation=paste("y = ",round(out$coef[2],2)," x")
            myequation=paste(myequation,ifelse(out$coef[1]>0," + "," - "),
                             round(abs(out$coef[1]),2))
            mtext(myequation,side=3,line=1)
        }
    }
  })
  
  # Generate a summary of the linear model statistics
  output$summary <- renderPrint({
      i=as.numeric(input$dist)
      myformula=paste("mtcars$mpg ~ mtcars$",colnames(mtcars)[i],sep="")
      out=lm(myformula)
      out$call=myformula
      summary(out)
  
  })
  
  # Generate a descriptive statistics
  output$desc <- renderPrint({
      i=as.numeric(input$dist)
      print(colnames(mtcars)[i])
      summary(mtcars[,i])
      
  })
  # Generate a overview
  output$overview <- renderPrint({
      
      cat("In this app, you can choose a independent variable of a mtcars database
       from left panel and you can see simple summary of a variable, summary of simple 
       linear regression test and a bivariate plot (xyplot or boxplot) on right panel. 
       You can choose some options of plots.You can choose whether or not show 
       legend, regression line and regression equation." )
    
      
      cat("I hope you enjoy this app. Thank you !")
      
      
  })
  
})
