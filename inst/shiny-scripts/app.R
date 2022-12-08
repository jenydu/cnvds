library(shiny)

# Define UI for data upload app ----
ui <- fluidPage(

  # App title ----
  titlePanel("Analyze Copy Number Variant (CNV) Regions Based on Dosage Sensitivity Scores"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(

      tags$p("Upload a .csv file that contains a list of CNV regions.
             If left empty, a sample input of 1000 CNV regions that is included
             in this package will be used as input."),
      tags$p("The file should contain 5 columns, in the order of:"),
      tags$ol(
        tags$li("chromosome number"),
        tags$li("start position"),
        tags$li("end position"),
        tags$li("type of CNV (DEL/DUP)"),
        tags$li("number of copies")
      ),
      tags$p("(Please also see the preview of the sample input below for formatting references.)"),
      # Input: Select a file ----
      fileInput("file1", "Upload your CSV file",
                multiple = FALSE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),

      # Input: Checkbox if file has header ----
      checkboxInput("header", "This .csv file contains a header", TRUE),

      # Input: Select separator ----
      radioButtons("sep", "Separator",
                   choices = c(Comma = ",",
                               Semicolon = ";",
                               Tab = "\t"),
                   selected = ","),

      # Input: Select quotes ----
      radioButtons("quote", "Quote",
                   choices = c(None = "",
                               "Double quote" = '"',
                               "Single quote" = "'"),
                   selected = ''),
      radioButtons("disp", "Preview of the Inputted Table",
                   choices = c(Head = "head",
                               All = "all"),
                   selected = "head"),
      tags$p("Please check that your input is formatted correctly before running the analysis."),
      tableOutput("tbl"),

      # Horizontal line ----
      tags$hr(style="border-color: black;"),

      tags$p("The CNVds package currently supports three dosage sensitivity score metrics:"),
      tags$ul(
        tags$li("Probability of loss intolerance (pLI):
                the probability that a gene is intolerant to a loss of function mutation."),
        tags$li("Probability of haploinsufficiency (pHI):
                the probability that a gene is sensitive to copy number loss."),
        tags$li("Probability of triplosensitivity (pTS):
                the probability that the gene is sensitive to copy number gain.")
      ),

      selectInput("score", "Choose a score metric:",
                  choices = c("Probability of loss intolerance (pLI)" = 'pLI',
                              "Probability of haploinsufficiency (pHI)" = 'pHI',
                              "Probability of triplosensitivity (pTS)" = 'pTS'),
                  selected = 'pHI'),

      selectInput("refGene", "Choose a reference genome (for annotation):",
                  choices = c("Genome Reference Consortium Human Build 37 (GRCh37)" = 'GRCh37',
                              "Genome Reference Consortium Human Build 38 (GRCh38)" = 'GRCh38'),
                  selected = 'grch37'),

      textInput(inputId = "thresh",
                label = "Enter a number between 0 and 1. Genes with scores above
                this threshold will be coloured in red.", "0.8"),

      actionButton(inputId = "button2",
                   label = "Run Analysis"),




    ),

    # Main panel for displaying outputs ----
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Overview of the Outputs",
                           tags$hr(style="border-color: black;"),
                           h4("Instructions: In the left side panel, upload your inputs in a .csv file, choose a dosage sensitivity
                              score, reference genome, and input a threshold value. Confirm your input is formatted correctly and click
                              'Run Analysis'. Alternatively, you can run this analysis on the sample input dataset provided in the package by leaving the file upload section empty."),
                           tags$hr(style="border-color: black;"),

                           h3("Summary of the Annotation Results"),
                           br(),
                           h4("Total Number of Genes Annotated"),
                           verbatimTextOutput("numGenes"),

                           h5("If the above number is abnormally low, check that
                              your inputs are formatted correctly. Also, besure
                              that you're inputting in human autosomal CNV regions."),
                           br(),
                           h4("Genes"),
                           verbatimTextOutput("geneList"),
                           br(),
                           h4("Scores"),
                           verbatimTextOutput("scoreList")),

                  tabPanel("CNV Region Distribution",
                           tags$hr(style="border-color: black;"),
                           h4("Instructions: In the left side panel, upload your inputs in a .csv file, choose a dosage sensitivity
                              score, reference genome, and input a threshold value. Confirm your input is formatted correctly and click
                              'Run Analysis'. Alternatively, you can run this analysis on the sample input dataset provided in the package by leaving the file upload section empty."),
                           tags$hr(style="border-color: black;"),
                           h3("Number of CNV Regions in Each Chromosome"),
                           br(),
                           plotOutput("CNVPlot")),

                  tabPanel("Score Distribution",
                           tags$hr(style="border-color: black;"),
                           h4("Instructions: In the left side panel, upload your inputs in a .csv file, choose a dosage sensitivity
                              score, reference genome, and input a threshold value. Confirm your input is formatted correctly and click
                              'Run Analysis'. Alternatively, you can run this analysis on the sample input dataset provided in the package by leaving the file upload section empty."),
                           tags$hr(style="border-color: black;"),
                           h3(paste0("Distribution of Gene Dosage Sensitivity Scores in Each Chromosome")),
                           br(),
                           plotOutput("annoPlot"))
      )
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
      output <- CNVds::annotateCNV(get_file_or_default()[i, 1],
                                   get_file_or_default()[i, 2],
                                   get_file_or_default()[i, 3],
                                   get_file_or_default()[i, 4],
                                   get_file_or_default()[i, 5],
                                   reference = input$refGene)
      annotated <- rbind(annotated, output)
    }

    if (input$score == 'pLI') {
      DSscores <- CNVds::findpLI(annotated$gene)
    } else if (input$score == 'pHI') {
      DSscores <- CNVds::findpHI(annotated$gene)
    } else {
      DSscores <- CNVds::findpTS(annotated$gene)
    }

    annotated <- merge(annotated, DSscores, by='gene')
    return(annotated[c('chr', 'gene', input$score)])
  })


  output$annoPlot <- renderPlot({
    if (! is.null(annotation()))
      plotScoresByChr(annotation(), input$score, as.numeric(input$thresh))
  })

  output$numGenes <- renderPrint({
    if (! is.null(annotation()))
      nrow(annotation())
  })
  output$geneList <- renderPrint({
    if (! is.null(annotation()))
      annotation()$gene
  })
  output$scoreList <- renderPrint({
    if (! is.null(annotation()))
      annotation()
  })

}

# Create Shiny app ----
shinyApp(ui, server)
