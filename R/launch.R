#' @title launch
#'
#' @description Launches a R Shiny-based applet for linear model diagnostics. 
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

  rlang::check_installed(
    c("shiny", "bslib", "DT", "ggthemes", "htmltools", "palmerpenguins",
      "RColorBrewer", "fivethirtyeight"),
    reason = "for `launch()`."
  )

  shiny::addResourcePath("gglm-www", system.file("www", package = "gglm"))

  example_datasets <- list(
    "penguins" = palmerpenguins::penguins,
    "candy" = fivethirtyeight::candy_rankings,
    "mtcars" = datasets::mtcars
  )
  
  theme_choices <- list(
    "Gray" = ggplot2::theme_gray,
    "Black & White" = ggplot2::theme_bw,
    "Minimal" = ggplot2::theme_minimal,
    "Classic" = ggplot2::theme_classic,
    "Light" = ggplot2::theme_light,
    "Dark" = ggplot2::theme_dark,
    "Linedraw" = ggplot2::theme_linedraw,
    "Void" = ggplot2::theme_void,
    "Economist" = ggthemes::theme_economist,
    "FiveThirtyEight" = ggthemes::theme_fivethirtyeight,
    "Tufte" = ggthemes::theme_tufte,
    "Wall Street Journal" = ggthemes::theme_wsj,
    "Stata" = ggthemes::theme_stata,
    "Google Docs" = ggthemes::theme_gdocs,
    "Few" = ggthemes::theme_few,
    "Solarized" = ggthemes::theme_solarized
  )
  
  stat_fn_map <- list(
    "Residuals vs Fitted" = stat_fitted_resid,
    "Normal Q-Q" = stat_normal_qq,
    "Scale-Location" = stat_scale_location,
    "Residual vs. Leverage" = stat_resid_leverage,
    "Cook's Distance vs. Leverage" = stat_cooks_leverage,
    "Cook's Distance (by Observation)" = stat_cooks_obs,
    "Residual Histogram" = stat_resid_hist
  )
  which_plot_choices <- c("Quartet", names(stat_fn_map))
  
  palette_category_labels <- c(seq = "Sequential", div = "Diverging", qual = "Qualitative")
  palette_info <- RColorBrewer::brewer.pal.info
  palette_choices <- stats::setNames(rownames(palette_info),
                                     paste0(rownames(palette_info), " (", palette_category_labels[palette_info$category], ")"))
  
  if (is.null(data)) {
    data_source_choices <- c("Built-in dataset" = "example",
                             "Upload" = "upload")
  } else {
    data_source_choices <- c(
      "Data supplied to gglm::launch()" = "supplied",
      "Built-in dataset" = "example",
      "Upload" = "upload"
    )
  }
  
  ui <- bslib::page_fillable(
    title = "Linear Model Diagnostics Dashboard",
    theme = bslib::bs_theme(
      version = 5,
      bootswatch = "zephyr",
      primary = "#E3A400",
      secondary = "#E8C25F"
    ),

    launch_css(),

    bslib::navset_bar(
      title = htmltools::tags$span(
        htmltools::tags$img(src = "gglm-www/gglm.gif", height = "40px", style = "margin-right: 8px;"),
        "Linear Model Diagnostics"
      ),
      id = "main_nav",
      navbar_options = bslib::navbar_options(bg = "#FCF4E0"),

      sidebar = bslib::sidebar(
        id = "data_sidebar",
        title = htmltools::tags$header(
          class = "sidebar-title",
          shiny::textOutput("sidebar_title_text", inline = TRUE)
        ),
        bg = "#FCF4E0",

        shiny::selectInput(
          "data_source",
          "Data source:",
          choices = data_source_choices,
          selected = if (!is.null(data))
            "supplied"
          else
            "example"
        ),

        shiny::conditionalPanel(
          condition = "input.data_source == 'upload'",
          shiny::fileInput("upload_file", "Upload CSV file:", accept = c(".csv"))
        ),
        shiny::conditionalPanel(
          condition = "input.data_source == 'example'",
          shiny::selectInput(
            "example_dataset",
            "Built-in dataset:",
            choices = names(example_datasets)
          )
        ),

        shiny::conditionalPanel(
          condition = "input.main_nav == 'Model Diagnostics'",
          shiny::selectInput("resp_var", "Response variable:", choices = NULL),
          shiny::selectInput(
            "aux_vars",
            "Auxiliary variable(s):",
            choices = NULL,
            multiple = TRUE
          ),
          shiny::selectInput(
            "interactions",
            "Interaction term(s):",
            choices = NULL,
            multiple = TRUE
          ),
          shiny::selectInput(
            "poly_vars",
            "Polynomial variable(s):",
            choices = NULL,
            multiple = TRUE
          ),
          shiny::uiOutput("poly_degree_inputs"),
          shiny::actionButton("fit_model", "Fit model")
        )
      ),

      bslib::nav_panel(
        "Model Diagnostics",

        bslib::layout_sidebar(
          border = FALSE,
          sidebar = bslib::sidebar(
            title = "Plot Customization",
            position = "right",
            bg = "#FCF4E0",

            shiny::selectInput("which_plot", "Which Plot?", choices = which_plot_choices),
            shiny::sliderInput(
              "point_alpha",
              "Point transparency:",
              min = 0.1,
              max = 1,
              value = 0.5,
              step = 0.05
            ),
            shiny::selectInput("color_var", "Color points by:", choices = c("None" = "")),
            shiny::conditionalPanel(
              condition = "input.color_var != ''",
              shiny::selectInput("color_palette", "Color palette:", choices = palette_choices)
            ),
            shiny::selectInput("plot_theme", "Plot theme:", choices = names(theme_choices)),
            shiny::actionButton("update_plot", "Update Plot")
          ),

          bslib::card(
            class = "border-0 shadow-none",
            bslib::card_header("Linear Model Diagnostic Plot(s)"),
            shiny::plotOutput("gglm_plot")
          )
        )
      ),

      bslib::nav_panel("Data", bslib::card(
        class = "border-0 shadow-none",
        bslib::card_header("Data"), DT::DTOutput("data_table")
      ))
    )
  )
  
  server <- function(input, output, session) {
    output$sidebar_title_text <- shiny::renderText({
      if (identical(input$main_nav, "Model Diagnostics")) "Model Builder" else "Data Explorer"
    })

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
    
    output$data_table <- DT::renderDT({
      active_data()
    })
    
    shiny::observeEvent(input$data_source,
                        {
                          shiny::updateSelectInput(session, "resp_var", choices = character(0))
                          shiny::updateSelectInput(session, "aux_vars", choices = character(0))
                          shiny::updateSelectInput(session, "poly_vars", choices = character(0))
                        },
                        priority = 10,
                        ignoreInit = TRUE)
    
    shiny::observeEvent(active_data(), {
      numeric_vars <- colnames(active_data())[vapply(active_data(), is.numeric, logical(1))]
      shiny::updateSelectInput(session, "resp_var", choices = numeric_vars)
      shiny::updateSelectInput(session, "aux_vars", choices = colnames(active_data()))
    })
    
    shiny::observeEvent(input$resp_var, {
      shiny::req(active_data())
      
      aux_choices <- setdiff(colnames(active_data()), input$resp_var)
      shiny::updateSelectInput(
        session,
        "aux_vars",
        choices = aux_choices,
        selected = shiny::isolate(input$aux_vars)[shiny::isolate(input$aux_vars) %in% aux_choices]
      )
    }, ignoreInit = TRUE)
    
    shiny::observeEvent(input$aux_vars, {
      interaction_choices <- if (length(input$aux_vars) >= 2) {
        utils::combn(
          input$aux_vars,
          2,
          FUN = function(x)
            paste(x, collapse = ":")
        )
      } else {
        character(0)
      }

      shiny::updateSelectInput(
        session,
        "interactions",
        choices = interaction_choices,
        selected = shiny::isolate(input$interactions)[shiny::isolate(input$interactions) %in% interaction_choices]
      )

      shiny::updateSelectInput(
        session,
        "poly_vars",
        choices = input$aux_vars,
        selected = shiny::isolate(input$poly_vars)[shiny::isolate(input$poly_vars) %in% input$aux_vars]
      )
    }, ignoreNULL = FALSE)

    output$poly_degree_inputs <- shiny::renderUI({
      shiny::req(input$poly_vars)

      lapply(input$poly_vars, function(v) {
        shiny::numericInput(
          paste0("poly_degree_", v),
          paste0("Degree for ", v, ":"),
          value = 2,
          min = 2,
          max = 5,
          step = 1
        )
      })
    })
    
    mod <- shiny::eventReactive(input$fit_model, {
      shiny::req(input$resp_var, input$aux_vars)

      poly_terms <- vapply(input$poly_vars, function(v) {
        degree <- input[[paste0("poly_degree_", v)]]
        sprintf("poly(%s, %d, raw = TRUE)", v, degree)
      }, character(1))

      linear_terms <- setdiff(input$aux_vars, input$poly_vars)
      formula_terms <- c(linear_terms, poly_terms, input$interactions)
      formula_str <- base::paste(input$resp_var,
                                 "~",
                                 base::paste(formula_terms, collapse = " + "))

      list(
        fit = stats::lm(stats::as.formula(formula_str), data = active_data()),
        aux_vars = input$aux_vars
      )
    })
    
    shiny::observeEvent(mod(), {
      shiny::updateSelectInput(session,
                               "color_var",
                               choices = c("None" = "", stats::setNames(mod()$aux_vars, mod()$aux_vars)))
    })
    
    plot_settings <- shiny::eventReactive(input$update_plot, {
      list(
        which_plot = input$which_plot,
        alpha = input$point_alpha,
        color_var = input$color_var,
        palette = input$color_palette,
        theme_name = input$plot_theme
      )
    }, ignoreNULL = FALSE)
    
    output$gglm_plot <- shiny::renderPlot({
      settings <- plot_settings()
      aug_data <- broom::augment(mod()$fit)
      theme_obj <- theme_choices[[settings$theme_name]]()
      
      color_arg <- if (!is.null(settings$color_var) &&
                       base::nzchar(settings$color_var)) {
        rlang::sym(settings$color_var)
      }
      color_mapping <- if (!is.null(color_arg)) {
        do.call(ggplot2::aes, stats::setNames(list(color_arg), "color"))
      } else {
        ggplot2::aes()
      }

      if (settings$which_plot == "Quartet") {
        gglm_args <- list(data = aug_data,
                          mapping = color_mapping,
                          alpha = settings$alpha,
                          theme = theme_obj)

        plot <- do.call(gglm::gglm, gglm_args)
      } else {
        stat_args <- list(mapping = color_mapping, alpha = settings$alpha)

        plot <- ggplot2::ggplot(aug_data) +
          do.call(stat_fn_map[[settings$which_plot]], stat_args) +
          theme_obj
      }
      
      if (!is.null(color_arg)) {
        scale_obj <- if (is.numeric(aug_data[[settings$color_var]])) {
          ggplot2::scale_color_distiller(palette = settings$palette)
        } else {
          ggplot2::scale_color_brewer(palette = settings$palette)
        }
        
        plot <- if (settings$which_plot == "Quartet")
          plot & scale_obj
        else
          plot + scale_obj
      }
      plot
    })
    
  }
  
  shiny::shinyApp(ui, server)
  
}
