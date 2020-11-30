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
                 value = 0),
    actionButton("BTN","Calculer")
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
                   value = 0),
      actionButton("BTN2","Calculer")
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
                          value = 0),
             actionButton("BTN3","Calculer")
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
                          value = 0),
             actionButton("BTN4","Calculer")
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
           
         )),

tabPanel("Simulation frais de notaire",
         sidebarLayout(
           sidebarPanel(
             h2("Estimation de vos frais de notaire"),
             br(),
             selectInput("type", "Type du bien", choices = c("Neuf" = "Nf","Ancien" = "An")),
             br(),
             numericInput(inputId = "P2",
                          label = "Prix du bien :",
                          value = 0),
             actionButton("BTN5","Calculer")
             
           ),
           mainPanel(h3(textOutput("RendementNetFraisCharges")))
           
         ))

))

# The three functions headerPanel, sidebarPanel, and mainPanel define the various regions of the user-interface. The application will be called “Calculs Investissements Locatifs” so we specify that as the title when we create the header panel. The other panels are empty for now.
# Now let’s define a skeletal server implementation. To do this we call shinyServer and pass it a function that accepts two parameters, input and output:

# Define server logic to plot various variables

server <- function(input, output) {
    
    results <- eventReactive(input$BTN, {
      format(round((input$La/input$P*100), 2), nsmall = 2)
    })
    output$RendementBrut <- renderText({
    paste("Le rendement brut s'élève à ", results(), "%")
  })
    
    results2 <- eventReactive(input$BTN2, {
      format(round(((input$La2-input$FC2)/(input$P2+input$Cc2)* 100), 2), nsmall = 2)
    })
    output$RendementNetFraisCharges <- renderText({
    paste("Le rendement net de frais et de charges s'élève à ", results2(), "%")
  })
    
    results3 <- eventReactive(input$BTN3, {
      format(round(((input$La3-input$FC3-input$Imp3)/(input$P3+input$Cc3)* 100), 2), nsmall = 2)
    })
      output$RendementNetNet <- renderText({
      paste("Le rendement net de frais, de charges et d'impôts s'élève à ", results3(), "%")
  })
    
      results4 <- eventReactive(input$BTN4, {
        format(round(((input$Sa4+input$SaCo4+input$Rf4+input$AR4)-(input$L4-input$Men4-input$AC4))*33/100, 0), nsmall = 0)
      })
      output$CapaciteEmprunt <- renderText({
      paste("Votre capacité de remboursement de crédit est estimée à", results4(), "€ par mois")
  })
      
      results42 <- eventReactive(input$BTN4, {
        format(round((((input$Sa4+input$SaCo4+input$Rf4+input$AR4)-(input$L4-input$Men4-input$AC4))*33/100)*120, 0), nsmall = 0)
      })
        output$CapaciteEmprunt10 <- renderText({
      paste("Votre capacité d'emprunt sur 10 ans est estimée à", results42(), "€")
  })
      
      results43 <- eventReactive(input$BTN4, {
        format(round((((input$Sa4+input$SaCo4+input$Rf4+input$AR4)-(input$L4-input$Men4-input$AC4))*33/100)*180, 0), nsmall = 0)
      })
      output$CapaciteEmprunt15 <- renderText({
      paste("Votre capacité d'emprunt sur 15 ans est estimée à", results43(), "€")
  })
   
      results44 <- eventReactive(input$BTN4, {
        format(round((((input$Sa4+input$SaCo4+input$Rf4+input$AR4)-(input$L4-input$Men4-input$AC4))*33/100)*240, 0), nsmall = 0)
      })
      output$CapaciteEmprunt20 <- renderText({
      paste("Votre capacité d'emprunt sur 20 ans est estimée à", results44(), "€")
  }) 
    
      results45 <- eventReactive(input$BTN4, {
        format(round((((input$Sa4+input$SaCo4+input$Rf4+input$AR4)-(input$L4-input$Men4-input$AC4))*33/100)*300, 0), nsmall = 0)
      })
        output$CapaciteEmprunt25 <- renderText({
      paste("Votre capacité d'emprunt sur 25 ans est estimée à", results45(), "€")
  })
    
      results46 <- eventReactive(input$BTN4, {
        format(round((((input$Sa4+input$SaCo4+input$Rf4+input$AR4)-(input$L4-input$Men4-input$AC4))*33/100)*360, 0), nsmall = 0)
      })
        output$CapaciteEmprunt30 <- renderText({
      paste("Votre capacité d'emprunt sur 30 ans est estimée à", results46(), "€")
  })
        
      #output$type <- renderText({
          #if output$type = "Nf" paste("You chose", input$state)
}


# Create Shiny App with ui and server

shinyApp(ui, server)

