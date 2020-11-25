library(shiny)
library(shinythemes)

# Define UI 

ui = fluidPage(theme = shinytheme("cerulean"),
     navbarPage("Calculs Investissements Locatifs",
     tabPanel("Rendement Brut",
     sidebarLayout(
  
  # App title
  headerPanel("Calculs Investissements Locatifs"),
  
  # Sidebar panel for inputs
  sidebarPanel(
    
    # Variables input
    h2("Calcul du rendement brut"),
    br(),
    numericInput(inputId = "La",
                 label = "Loyer annuel :",
                 value = 0),
    numericInput(inputId = "P",
                 label = "Prix du bien :",
                 value = 0)
    ),
  
  # Main panel for displaying outputs
  mainPanel(h3(textOutput("RendementBrut")))
     )
  ),
  

tabPanel("Rendement net de frais et charges",
  sidebarLayout(
    sidebarPanel(
      h2("Calcul du rendement net de frais et charges"),
      br(),
      numericInput(inputId = "La2",
                   label = "Loyer annuel",
                   value = 0),
      numericInput(inputId = "P2",
                   label = "Prix du bien",
                   value = 0),
      numericInput(inputId = "FC2",
                   label = "Frais et Charges (annuelles)",
                   value = 0),
      numericInput(inputId = "Cc2",
                   label = "Coût du crédit",
                   value = 0)
    ),
    mainPanel(h3(textOutput("RendementNetFraisCharges")))

))
))

# The three functions headerPanel, sidebarPanel, and mainPanel define the various regions of the user-interface. The application will be called “Calculs Investissements Locatifs” so we specify that as the title when we create the header panel. The other panels are empty for now.
# Now let’s define a skeletal server implementation. To do this we call shinyServer and pass it a function that accepts two parameters, input and output:

# Define server logic to plot various variables

server <- function(input, output, session) {
    output$RendementBrut <- renderText({
    results <- (input$La/input$P*100)
    results <- format(round(results, 2), nsmall = 2)
    paste("Le rendement brut s'élève à ", results, "%")
  })

    output$RendementNetFraisCharges <- renderText({
    results <- (input$La2-input$FC2)/(input$P2+input$Cc2)* 100
    results <- format(round(results, 2), nsmall = 2)
    paste("Le rendement net de frais et de charges s'élève à ", results, "%")
  })
}


# Create Shiny App with ui and server

shinyApp(ui, server)

runApp("CalculsInvestissementsLocatifs")

