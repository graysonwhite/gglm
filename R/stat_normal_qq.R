#' @title stat_normal_qq
#'
#' @description Normal QQ plot.
#'
#' @param alpha Adjust transparency of points.
#' @param ... Additional arguments to be passed to the `aes()` of `stat_qq()`.
#' These arguments correspond to the aesthetics of the points on the plot.
#'
#' @return A `ggplot2` layer for plotting a Normal Q-Q plot.
#' @examples
#' data(mtcars)
#' model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
#' ggplot2::ggplot(data = model) + stat_normal_qq()
#' @export
#' @importFrom rlang .data

stat_normal_qq <- function(alpha = 0.5,
                           ...) {
  list(
    ggplot2::geom_qq_line(mapping = ggplot2::aes(sample = .data$.resid / stats::sd(.data$.resid)),
                          linetype = "dashed"),
    ggplot2::geom_point(mapping = ggplot2::aes(
      x = stats::qnorm(stats::ppoints(base::length(.data$.resid)))[rank(.data$.resid / stats::sd(.data$.resid))],
      y = .data$.resid / stats::sd(.data$.resid),
      ... = ...),
                        alpha = alpha),
    ggplot2::labs(title = "Normal Q-Q",
                  x = "Theoretical Quantiles",
                  y = "Standardized Residuals")
  )
}
