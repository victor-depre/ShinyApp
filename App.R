library(shiny)

# Define UI 

ui <- pageWithSidebar(
  
  # App title
  headerPanel("Calculs Investissements Locatifs"),
  
  # Sidebar panel for inputs
  sidebarPanel(
  
  # Input: Selector for variable 
  selectInput("variable", "Variable:", 
              c("Cylinders" = "cyl",
                "Transmission" = "am",
                "Gears" = "gear")),
  
  # Input: Checkbox for whether outliers should be included
  checkboxInput("outliers", "Show outliers", TRUE)
  
  ),
  
  
  # Main panel for displaying outputs
  mainPanel()
)

# The three functions headerPanel, sidebarPanel, and mainPanel define the various regions of the user-interface. The application will be called “Calculs Investissements Locatifs” so we specify that as the title when we create the header panel. The other panels are empty for now.
# Now let’s define a skeletal server implementation. To do this we call shinyServer and pass it a function that accepts two parameters, input and output:

# Define server logic to plot various variables

server <- function(input, output) {
  
}

# Create Shiny App with ui and server

shinyApp(ui, server)

runApp("~/shinyapp")
