#' @title stat_normal_qq
#'
#' @description Normal QQ plot.
#'
#' @param mapping Additional aesthetic mappings to add to the layer, e.g.
#' `aes(color = some_var)`.
#' If `mapping` includes a required aesthetic (e.g. `x`, `y`), the supplied
#' value is ignored in favor of the default and a warning is issued.
#' @param alpha Adjust transparency of points.
#' @param ... Additional arguments passed on to `geom_point()`.
#'
#' @return A `ggplot2` layer for plotting a Normal Q-Q plot.
#' @examples
#' data(mtcars)
#' model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
#' ggplot2::ggplot(data = model) + stat_normal_qq()
#' @export
#' @importFrom rlang .data

stat_normal_qq <- function(mapping = ggplot2::aes(),
                           alpha = 0.5,
                           ...) {
  mapping <- merge_required_aes(
    ggplot2::aes(
      x = qq_theoretical_quantiles(.data$.resid),
      y = .data$.resid / stats::sd(.data$.resid)
    ),
    mapping
  )

  list(
    ggplot2::geom_qq_line(mapping = ggplot2::aes(sample = .data$.resid / stats::sd(.data$.resid)),
                          linetype = "dashed"),
    ggplot2::geom_point(mapping = mapping, alpha = alpha, ...),
    ggplot2::labs(title = "Normal Q-Q",
                  x = "Theoretical Quantiles",
                  y = "Standardized Residuals")
  )
}
