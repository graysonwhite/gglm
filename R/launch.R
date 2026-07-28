#' @title launch
#'
#' @description Launch a R Shiny-based applet for model diagnostics.
#'
#' @param data A `data.frame` to use in modeling.
#' @param ... Currently ignored. For extendability.
#'
#' @return None. Launches a `shiny` applet for point-and-click based model
#' diagnostics
#' @examples
#' \dontrun{
#' launch()
#' }
#' @export

launch <- function(data = NULL,
                   ...) {
  # this will only be needed if I allow people to supply a model to launch(),
  # but right now, I am thinking it makes the most sense to only let them supply
  # data.
  
  #   if (!is.null(data)) {
  #     if (!any(class(data) %in% c("data.frame", "tbl_df", "tbl"))) {
  #       data <- tryCatch({
  #         broom::augment(data)
  #       },
  #       error = function(cond) {
  #         tryCatch({
  #           ggplot2::fortify(data)
  #         },
  #         error = function(cond) {
  #           message(
  #             "It looks like you supplied an object that isn't compatible with `gglm`.
  # Note that for `gglm` to work, there must be an applicable method from `broom` or
  # `broom.mixed` to `augment()` the data, or an applicable method from `ggplot2` to
  # `fortify()` the data.")
  #           data
  #         })
  #       })
  #     }
  #   }
  
  ui <- bslib::page_sidebar(
    title = "Linear Model Diagnostics",
    theme = bslib::bs_theme(version = 5, bootswatch = "zephyr"),
    
    sidebar = bslib::sidebar(
      title = "Controls",
      shiny::selectInput(
        "resp_var", "Response variable:",
        choices = colnames(data),
        selected = NULL
      ),
      shiny::selectInput(
        "aux_vars", "Auxiliary variable(s):",
        choices = colnames(data),
        selected = NULL,
        multiple = TRUE
      ),
      shiny::actionButton(
        "fit_model", "Fit model"
      )
    ),
    
    bslib::layout_columns(
      bslib::card(
        bslib::card_header("Model Diagnostic Quartet"),
        shiny::plotOutput("gglm_plot")
      )
    )
  )
  
  server <- function(input, output, session) {
    
    mod <- shiny::eventReactive(input$fit_model, {
      shiny::req(input$resp_var, input$aux_vars)
      
      formula_str <- base::paste(
        input$resp_var, "~", base::paste(input$aux_vars, collapse = " + ")
      )
      
      stats::lm(stats::as.formula(formula_str), data = data)
    })
    
    
    output$gglm_plot <- shiny::renderPlot({
      gglm::gglm(data = mod())
    })
    
  }
  
  shiny::shinyApp(ui, server)
  
}
