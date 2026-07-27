#' @title stat_resid_leverage
#'
#' @description Residual vs. leverage plot.
#'
#' @param alpha Adjust transparency of points.
#' @param method Method for fitting the line to the points.
#' @param se Keep standard error bands around line?
#' @param linecolor Color of the line.
#' @param ... Additional arguments to be passed to the `aes()` in `geom_point()`.
#'
#' @return A `ggplot2` layer for plotting a fitted vs. residual scatter plot.
#' @examples
#' data(mtcars)
#' model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
#' ggplot2::ggplot(data = model) + stat_resid_leverage()
#' @export
#' @importFrom rlang .data

stat_resid_leverage <-
  function(
           alpha = 0.5,
           method = "loess",
           se = FALSE,
           linecolor = "steelblue",
           ...) {
    list(
      ggplot2::geom_point(
        mapping = ggplot2::aes(x = .data$.hat,
                               y = .data$.resid / stats::sd(.data$.resid),
                               ... = ...),
        alpha = alpha
      ),
      ggplot2::geom_smooth(
        mapping = ggplot2::aes(x = .data$.hat,
                               y = .data$.resid / stats::sd(.data$.resid)),
        method = method,
        se = se,
        color = linecolor,
        linewidth = 1,
        formula = "y ~ x"
      ),
      ggplot2::labs(title = "Residual vs. Leverage",
                    y = "Standardized Residuals",
                    x = "Leverage")
    )
  }
