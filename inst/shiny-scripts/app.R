library(shiny)
library(shinyalert)

# Define UI for data upload app ----
ui <- fluidPage(

  # App title ----
  titlePanel("Uploading Files"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(

      # Input: Select a file ----
      fileInput("file1", "Choose CSV File",
                multiple = FALSE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),


      # actionButton(inputId = "button1",
      #              label = "Sample Input"),

      # Horizontal line ----
      tags$hr(),

      # Input: Checkbox if file has header ----
      checkboxInput("header", "Header", TRUE),

      # Input: Select separator ----
      radioButtons("sep", "Separator",
                   choices = c(Comma = ",",
                               Semicolon = ";",
                               Tab = "\t"),
                   selected = ","),

      # Input: Select quotes ----
      radioButtons("quote", "Quote",
                   choices = c(None = "",
                               "Double Quote" = '"',
                               "Single Quote" = "'"),
                   selected = '"'),

      # Horizontal line ----
      tags$hr(),

      # Input: Select number of rows to display ----
      radioButtons("disp", "Display",
                   choices = c(Head = "head",
                               All = "all"),
                   selected = "head"),

      selectInput("score", "Choose a score metric:",
                  choices = c("Probability of loss intolerance (pLI)" = 'pLI',
                              "Probability of haploinsufficiency (pHI)" = 'pHI',
                              "Probability of triplosensitivity (pTS)" = 'pTS'),
                  selected = 'pHI'),

      actionButton(inputId = "button2",
                   label = "Run Analysis"),
      tableOutput("tbl"),




    ),

    # Main panel for displaying outputs ----
    mainPanel(
      plotOutput("CNVPlot"),
      plotOutput("annoPlot")

    )

  )
)

# Define server logic to read selected file ----
server <- function(input, output) {
  get_file_or_default <- reactive({
    if (is.null(input$file1)) {
      inputPath <- system.file("extdata", "sampleInputCNV.csv", package = "CNVds")
      read.csv(file = inputPath, header = TRUE)
    } else {
      read.csv(input$file1$datapath,
               header = input$header,
               sep = input$sep,
               quote = input$quote)
    }
  })

  output$tbl <- renderTable({
      if(input$disp == "head") {
        return(head(get_file_or_default()))
      }
      else {
        return(get_file_or_default())
      }
    })


  CNVinfo <- eventReactive(eventExpr = input$button2, {
    return(get_file_or_default()[c(1:4)])

  })

  output$CNVPlot <- renderPlot({
    if (! is.null(CNVinfo()))
      CNVds::plotCNVcounts(CNVinfo())
  })

  annotation <- eventReactive(eventExpr = input$button2, {
    annotated <- NULL
    for (i in seq_along(1:nrow(get_file_or_default()))) {
      output <- CNVds::annotateCNV(get_file_or_default()[i, 1], get_file_or_default()[i, 2],
                            get_file_or_default()[i, 3], get_file_or_default()[i, 4],
                            get_file_or_default()[i, 5], reference = 'GRCh37')
      annotated <- rbind(annotated, output)
    }

    if (input$score == 'pLI') {
      DSscores <- findpLI(annotated$gene)
    } else if (input$score == 'pHI') {
      DSscores <- findpHI(annotated$gene)
    } else {
      DSscores <- findpTS(annotated$gene)
    }

    annotated <- merge(annotated, DSscores, by='gene')
    return(annotated[c('chr', 'gene', input$score)])
  })


  output$annoPlot <- renderPlot({
    if (! is.null(annotation()))
      plotScoresByChr(annotation(), input$score, 0.8)
  })


}

# Create Shiny app ----
shinyApp(ui, server)
