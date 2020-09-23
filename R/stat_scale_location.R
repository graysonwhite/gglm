#' @title stat_scale_location
#'
#' @description Provides four standard visual model diagnostic plots with `ggplot2`.
#'
#' @param model An object of type `lm` or `glm`
#'
#' @return A a `ggplot2` object for visual diagnostic of model validity.
#' @examples
#'
#' @export

stat_scale_location <- function() {
  list(
    ggplot2::geom_point(mapping = ggplot2::aes(x = .data$.fitted,
                                               y = sqrt(abs(.data$.std.resid))),
                        na.rm = TRUE,
                        alpha = 0.5),
    ggplot2::stat_smooth(mapping = ggplot2::aes(x = .data$.fitted,
                                                y = sqrt(abs(.data$.std.resid))),
                         method = "loess",
                         se = FALSE,
                         color = "steelblue",
                         formula = "y ~ x"),
    ggplot2::labs(x = "Fitted values",
                  y = expression(sqrt("|Standardized residuals|")),
                  title = "Scale-Location"),
    ggplot2::theme_bw()
  )
}
