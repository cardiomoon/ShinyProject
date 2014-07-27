library(shiny)

# Define UI for random distribution application 
shinyUI(fluidPage(
    
  # Application title
  titlePanel("Autmobile Fuel Consumption"),
  
  # Sidebar with controls to select the independent variable
  # and options of plot to generate. Note the use of the
  # br() element to introduce extra vertical spacing
  sidebarLayout(
    sidebarPanel(
        radioButtons("dist", "Select Independent Variable:",
                   c("Cylinders" = 2, "Displacement" = 3, 
                     "HorsePower" = 4, "drat" = 5,
                     "Weight(lb/1000)"=6, "qsec" =7,
                     "V/S"=8,"Transmission"=9,
                     "Forward gear"=10,"Carburetors"=11)),
        br(),
        radioButtons("col", "Color discrimination :",
                     c("Cylinders" = 2, "Transmission"=9)),
        checkboxInput("choice",label="show regression line",value=TRUE),
        checkboxInput("equation",label="show regression equation",value=TRUE),
        checkboxInput("legend",label="show legend",value=TRUE)        
    ),
    
    # Show a tabset that includes a plot, summary, and table view
    # of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs", 
        tabPanel("Overview", htmlOutput("overview")),          
        tabPanel("Descriptive", verbatimTextOutput("desc")),
        tabPanel("Summary", verbatimTextOutput("summary")),
        tabPanel("Plot", plotOutput("plot")) 
         
        
      )
    )
  )
))
