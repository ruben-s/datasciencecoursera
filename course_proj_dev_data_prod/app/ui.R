library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Prediction of birthweight based on situation of the Mother."),
  
  h6("The data used in this application was sourced from:"),
  p("Hosmer, D.W., Lemeshow, S. and Sturdivant, R.X. (2013); Applied Logistic Regression: Third Edition."),
  p("These data are copyrighted by John Wiley & Sons Inc. and must 
  be acknowledged and used accordingly."),
  p("Data were collected at Baystate Medical Center, Springfield, Massachusetts during 1986."),
  br(),br(),
 
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(h4("Situation of Mother"),
      sliderInput("Age",
                  "Age of Mother: [Years]",
                  min = 14,
                  max = 50,
                  value = 25),
      sliderInput("Lastweight",
                  "Weight of Mother: [Pounds]",
                  min = 50,
                  max = 300,
                  value = 200),
      sliderInput("Visitsfirsttrim",
                  "Nr of Physician Visits during 1st Trimester:",
                  min = 0,
                  max = 10,
                  value = 2),
      checkboxInput("Smoke", label = "Smoking during pregnancy", value = FALSE),
      checkboxInput("Histprematlabour", label = "History of Premature Labor", value = FALSE),
      checkboxInput("Histhyper", label = "History of Hypertension", value = FALSE),
      checkboxInput("Uterirr", label = "Presence of Uterine Irritability", value = FALSE),
      radioButtons("Race", "Ethnic origin of mother:",
                   c("White" = 1,
                     "Black" = 2,
                     "Other" = 3),
                   selected = 3)
      ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h2("Birthweight Prediction"),
      wellPanel(
        p("Note: a model is built when starting this application, this takes some time.")
      ),
      h5("Expected birthweigth"),
      textOutput("BirthWeight"),
      br(),
      p("Standard Deviation: +/- 700 Grams"),
      wellPanel(
        p("Note: The model has quite a large uncertainty."),
        p("Probably more data and a better model is needed."),
        p("However this is beyond the scope of the \"Developming Data Products\" assignment which focusses on building a Shiny application.")    
    )
  )
)))