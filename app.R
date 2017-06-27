#######################################################################################
# this app loosely derived from skeleton at 
# https://shiny.rstudio.com/gallery/reactivity.html

library(shiny)
#######################################################################################

#######################################################################################
# server component

server <- function(input, output) {
   # read full list of genes (could update later to only read sampled lines)
   dat <- read.table("hgnc_symbols.txt", sep="\t", header=FALSE, 
                     stringsAsFactors=FALSE)$V1
   
   output$view <- renderTable({
      set.seed(input$seed)
      rows <- sample(1:length(dat), input$genes, replace=FALSE)
      dat[rows]
      #head(datasetInput(), n = input$genes)
   }, colnames=FALSE)
}

#######################################################################################
# ui component

ui <- fluidPage(
   
   # Application title
   titlePanel("Random gene generator"),
   
   # select seed, number of genes
   sidebarLayout(
      sidebarPanel(
         numericInput("seed", "Set random seed:", 8675309),
         numericInput("genes", "Number of genes to generate:", 10)
      ),
      
      # Show the caption, a summary of the dataset and an HTML 
      # table with the requested number of observations
      mainPanel(
         verbatimTextOutput("summary"), 
         tableOutput("view")
      )
   )
)

#######################################################################################
shinyApp(ui = ui, server = server)
#######################################################################################
