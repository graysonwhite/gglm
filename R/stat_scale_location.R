#' @title stat_scale_location
#'
#' @description Scale location diagnostic plot.
#'
#' @param alpha Adjust the transparency of points.
#' @param na.rm Remove points with value NA?
#' @param se Keep standard error bands around line?
#' @param method Method for fitting the line to the points.
#' @param color Color of the line.
#' @param ... Currently ignored. For extendability.
#'
#' @return A `ggplot2` layer for plotting the scale location diagnostic plot.
#' @examples
#' data(mtcars)
#' model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
#' ggplot2::ggplot(data = model) + stat_scale_location()
#' @export
#' @importFrom rlang .data

stat_scale_location <- function(alpha = 0.5,
                                na.rm = TRUE,
                                se = FALSE,
                                method = "loess",
                                color = "steelblue",
                                ...) {
  list(
    ggplot2::geom_point(mapping = ggplot2::aes(x = .data$.fitted,
                                               y = sqrt(abs(.data$.resid / stats::sd(.data$.resid)))),
                        na.rm = na.rm,
                        alpha = alpha),
    ggplot2::stat_smooth(mapping = ggplot2::aes(x = .data$.fitted,
                                                y = sqrt(abs(.data$.resid / stats::sd(.data$.resid)))),
                         method = method,
                         se = se,
                         color = color,
                         formula = "y ~ x"),
    ggplot2::labs(x = "Fitted values",
                  y = expression(sqrt("|Standardized residuals|")),
                  title = "Scale-Location")
  )
}
