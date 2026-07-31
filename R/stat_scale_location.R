#' @title stat_scale_location
#'
#' @description Scale location diagnostic plot.
#'
#' @param mapping Additional aesthetic mappings to add to the layer, e.g.
#' `aes(color = some_var)`.
#' If `mapping` includes a required aesthetic (e.g. `x`, `y`), the supplied
#' value is ignored in favor of the default and a warning is issued.
#' @param alpha Adjust the transparency of points.
#' @param na.rm Remove points with value NA?
#' @param se Keep standard error bands around line?
#' @param method Method for fitting the line to the points.
#' @param linecolor Color of the line.
#' @param ... Additional arguments passed on to `geom_point()`.
#'
#' @return A `ggplot2` layer for plotting the scale location diagnostic plot.
#' @examples
#' data(mtcars)
#' model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
#' ggplot2::ggplot(data = model) + stat_scale_location()
#' @export
#' @importFrom rlang .data

stat_scale_location <- function(mapping = ggplot2::aes(),
                                alpha = 0.5,
                                na.rm = TRUE,
                                se = FALSE,
                                method = "loess",
                                linecolor = "steelblue",
                                ...) {
  mapping <- merge_required_aes(
    ggplot2::aes(x = .data$.fitted, y = sqrt(abs(.data$.resid / stats::sd(.data$.resid)))),
    mapping
  )

  list(
    ggplot2::geom_point(mapping = mapping,
                        na.rm = na.rm,
                        alpha = alpha,
                        ...),
    ggplot2::stat_smooth(mapping = ggplot2::aes(x = .data$.fitted,
                                                y = sqrt(abs(.data$.resid / stats::sd(.data$.resid)))),
                         method = method,
                         se = se,
                         color = linecolor,
                         formula = "y ~ x"),
    ggplot2::labs(x = "Fitted values",
                  y = expression(sqrt("|Standardized residuals|")),
                  title = "Scale-Location")
  )
}
