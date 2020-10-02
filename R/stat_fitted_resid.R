#' @title stat_fitted_resid
#'
#' @description `ggplot2` layer for plotting a fitted vs. residual scatter plot.
#'
#' @param alpha Adjust transparency of points.
#' @param ... Currently ignored. For extendability.
#'
#' @return A `ggplot2` layer for plotting a fitted vs. residual scatter plot.
#' @examples
#' data(mtcars)
#' model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
#' ggplot2::ggplot(data = model) + stat_fitted_resid()
#' @export
#' @importFrom rlang .data

stat_fitted_resid <- function(alpha = 0.5,
                              ...) {
  list(
    ggplot2::geom_point(mapping = ggplot2::aes(x = .data$.fitted,
                                               y = .data$.resid),
                        alpha = alpha),
    ggplot2::geom_hline(yintercept = 0,
                        linetype = "dashed"),
    ggplot2::labs(
      title = "Residuals vs Fitted",
      x = "Fitted values",
      y = "Residuals"
    )
    )
}
