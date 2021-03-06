library(shiny)
library(shinythemes)

# Define UI 

ui = fluidPage(theme = shinytheme("cerulean"),
     navbarPage("Simulateur Investissement Locatif",
  
 tabPanel("Rendement Brut",
     sidebarLayout(
  
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
                   label = "Loyer annuel :",
                   value = 0),
      numericInput(inputId = "P2",
                   label = "Prix du bien :",
                   value = 0),
      numericInput(inputId = "FC2",
                   label = "Frais et Charges (annuelles) :",
                   value = 0),
      numericInput(inputId = "Cc2",
                   label = "Coût du crédit :",
                   value = 0)
    ),
    mainPanel(h3(textOutput("RendementNetFraisCharges")))

)),


tabPanel("Rendement net-net",
         sidebarLayout(
           sidebarPanel(
             h2("Calcul du rendement net de frais de charges et d'impôts"),
             br(),
             numericInput(inputId = "La3",
                          label = "Loyer annuel :",
                          value = 0),
             numericInput(inputId = "P3",
                          label = "Prix du bien :",
                          value = 0),
             numericInput(inputId = "FC3",
                          label = "Frais et Charges (annuelles) :",
                          value = 0),
             numericInput(inputId = "Cc3",
                          label = "Coût du crédit :",
                          value = 0),
             numericInput(inputId = "Imp3",
                          label = "Impôts liés au logement :",
                          value = 0)
           ),
           mainPanel(h3(textOutput("RendementNetNet")))
           
         )),


tabPanel("Capacité d'emprunt",
         sidebarLayout(
           sidebarPanel(
             h2("Calcul de la capacité d'emprut"),
             br(),
             numericInput(inputId = "Sa4",
                          label = "Salaire mensuel :",
                          value = 0),
             numericInput(inputId = "SaCo4",
                          label = "Salaire co-emprunteur :",
                          value = 0),
             numericInput(inputId = "Rf4",
                          label = "Revenus fonciers mensuels :",
                          value = 0),
             numericInput(inputId = "AR4",
                          label = "Autres revenus mensuels :",
                          value = 0),
             numericInput(inputId = "L4",
                          label = "Loyer à charge après acquisition :",
                          value = 0),
             numericInput(inputId = "Men4",
                          label = "Mensualités de potentiels crédits en cours :",
                          value = 0),
             numericInput(inputId = "AC4",
                          label = "Autres charges mensuelles :",
                          value = 0)
           ),
           mainPanel(h3(textOutput("CapaciteEmprunt"),
                        br(),
                        h3(textOutput("CapaciteEmprunt10"),
                        br(),
                        h3(textOutput("CapaciteEmprunt15"),
                        br(),
                        h3(textOutput("CapaciteEmprunt20"),
                        br(),
                        h3(textOutput("CapaciteEmprunt25"),
                        br(),
                        h3(textOutput("CapaciteEmprunt30"))))))))
           
         ))



))

# The three functions headerPanel, sidebarPanel, and mainPanel define the various regions of the user-interface. The application will be called “Calculs Investissements Locatifs” so we specify that as the title when we create the header panel. The other panels are empty for now.
# Now let’s define a skeletal server implementation. To do this we call shinyServer and pass it a function that accepts two parameters, input and output:

# Define server logic to plot various variables

server <- function(input, output) {
    output$RendementBrut <- renderText({
    results <- (input$La/input$P*100)
    results <- format(round(results, 2), nsmall = 2)
    paste("Le rendement brut s'élève à ", results, "%")
  })

    output$RendementNetFraisCharges <- renderText({
    results2 <- ((input$La2-input$FC2)/(input$P2+input$Cc2)* 100)
    results2 <- format(round(results2, 2), nsmall = 2)
    paste("Le rendement net de frais et de charges s'élève à ", results2, "%")
  })
    
    output$RendementNetNet <- renderText({
      results3 <- ((input$La3-input$FC3-input$Imp3)/(input$P3+input$Cc3)* 100)
      results3 <- format(round(results3, 2), nsmall = 2)
      paste("Le rendement net de frais, de charges et d'impôts s'élève à ", results3, "%")
  })
    
    output$CapaciteEmprunt <- renderText({
      results4 <- ((input$Sa4+input$SaCo4+input$Rf4+input$AR4)-(input$L4-input$Men4-input$AC4))*33/100
      results4 <- format(round(results4, 2), nsmall = 2)
      paste("Votre capacité de remboursement de crédit est estimée à", results4, "€ par mois")
  })
    
    output$CapaciteEmprunt10 <- renderText({
      results42 <- (((input$Sa4+input$SaCo4+input$Rf4+input$AR4)-(input$L4-input$Men4-input$AC4))*33/100)*120
      results42 <- format(round(results42, 2), nsmall = 2)
      paste("Votre capacité d'emprunt sur 10 ans est estimée à", results42, "€")
  })
    
    output$CapaciteEmprunt15 <- renderText({
      results43 <- (((input$Sa4+input$SaCo4+input$Rf4+input$AR4)-(input$L4-input$Men4-input$AC4))*33/100)*180
      results43 <- format(round(results43, 2), nsmall = 2)
      paste("Votre capacité d'emprunt sur 15 ans est estimée à", results43, "€")
  })
   
    output$CapaciteEmprunt20 <- renderText({
      results44 <- (((input$Sa4+input$SaCo4+input$Rf4+input$AR4)-(input$L4-input$Men4-input$AC4))*33/100)*240
      results44 <- format(round(results44, 2), nsmall = 2)
      paste("Votre capacité d'emprunt sur 20 ans est estimée à", results44, "€")
  }) 
    
    output$CapaciteEmprunt25 <- renderText({
      results45 <- (((input$Sa4+input$SaCo4+input$Rf4+input$AR4)-(input$L4-input$Men4-input$AC4))*33/100)*300
      results45 <- format(round(results45, 2), nsmall = 2)
      paste("Votre capacité d'emprunt sur 25 ans est estimée à", results45, "€")
  })
    
    output$CapaciteEmprunt30 <- renderText({
      results46 <- (((input$Sa4+input$SaCo4+input$Rf4+input$AR4)-(input$L4-input$Men4-input$AC4))*33/100)*360
      results46 <- format(round(results46, 2), nsmall = 2)
      paste("Votre capacité d'emprunt sur 30 ans est estimée à", results46, "€")
  })
}


# Create Shiny App with ui and server

shinyApp(ui, server)