#' @title launch
#'
#' @description Launch a R Shiny-based applet for model diagnostics.
#'
#' @param data A `data.frame` to use in modeling.
#' @param ... Currently ignored. For extendability.
#'
#' @return None. Launches a `shiny` applet for point-and-click based model
#' diagnostics.
#' @examples
#' \dontrun{
#' launch()
#' }
#' @export

launch <- function(data = NULL, ...) {
  # Placeholder for example datasets to be supplied later, e.g.:
  # example_datasets <- list("mtcars" = datasets::mtcars, "iris" = datasets::iris)
  example_datasets <- list()
  
  data_source_choices <- c(
    "Upload your own data" = "upload",
    "Data supplied to launch()" = "supplied",
    "Example dataset" = "example"
  )
  
  ui <- bslib::page_sidebar(
    title = "Linear Model Diagnostics",
    theme = bslib::bs_theme(version = 5, bootswatch = "zephyr"),
    
    sidebar = bslib::sidebar(
      title = "Controls",
      
      shiny::selectInput(
        "data_source",
        "Data source:",
        choices = data_source_choices,
        selected = if (!is.null(data)) "supplied" else "upload"
      ),
      
      # source-specific controls -------------------------------------------
      shiny::conditionalPanel(
        condition = "input.data_source == 'upload'",
        shiny::fileInput("upload_file", "Upload CSV file:", accept = c(".csv"))
      ),
      shiny::conditionalPanel(
        condition = "input.data_source == 'example'",
        shiny::selectInput(
          "example_dataset",
          "Example dataset:",
          choices = names(example_datasets)
        )
      ),
      
      # shared model controls -----------------------------------------------
      shiny::selectInput("resp_var", "Response variable:", choices = NULL),
      shiny::selectInput(
        "aux_vars",
        "Auxiliary variable(s):",
        choices = NULL,
        multiple = TRUE
      ),
      shiny::actionButton("fit_model", "Fit model")
    ),
    
    bslib::layout_columns(bslib::card(
      bslib::card_header("Model Diagnostic Quartet"),
      shiny::plotOutput("gglm_plot")
    ))
  )
  
  server <- function(input, output, session) {
    
    active_data <- shiny::reactive({
      switch(
        input$data_source,
        upload = {
          shiny::req(input$upload_file)
          utils::read.csv(input$upload_file$datapath)
        },
        supplied = {
          shiny::req(data)
          data
        },
        example = {
          shiny::req(input$example_dataset)
          example_datasets[[input$example_dataset]]
        }
      )
    })
    
    shiny::observeEvent(active_data(), {
      shiny::updateSelectInput(session, "resp_var", choices = colnames(active_data()))
      shiny::updateSelectInput(session, "aux_vars", choices = colnames(active_data()))
    })
    
    mod <- shiny::eventReactive(input$fit_model, {
      shiny::req(input$resp_var, input$aux_vars)
      
      formula_str <- base::paste(
        input$resp_var,
        "~",
        base::paste(input$aux_vars, collapse = " + ")
      )
      
      stats::lm(stats::as.formula(formula_str), data = active_data())
    })
    
    output$gglm_plot <- shiny::renderPlot({
      gglm::gglm(data = mod())
    })
    
  }
  
  shiny::shinyApp(ui, server)
  
}
