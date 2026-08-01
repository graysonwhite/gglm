#' @title stat_fitted_resid
#'
#' @description \code{ggplot2} layer for plotting a fitted vs. residual scatter plot.
#'
#' @param mapping Additional aesthetic mappings to add to the layer, e.g.
#' \code{aes(color = some_var)}.
#' If \code{mapping} includes a required aesthetic (e.g. \code{x}, \code{y}), the supplied
#' value is ignored in favor of the default and a warning is issued.
#' @param alpha Adjust transparency of points.
#' @param ... Additional arguments passed on to \code{geom_point()}.
#'
#' @return A \code{ggplot2} layer for plotting a fitted vs. residual scatter plot.
#' @examples
#' data(mtcars)
#' model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
#' ggplot2::ggplot(data = model) + stat_fitted_resid()
#' @export
#' @importFrom rlang .data

stat_fitted_resid <- function(mapping = ggplot2::aes(),
                              alpha = 0.5,
                              ...) {
  mapping <- merge_required_aes(
    ggplot2::aes(x = .data$.fitted, y = .data$.resid),
    mapping
  )

  list(
    ggplot2::geom_point(mapping = mapping, alpha = alpha, ...),
    ggplot2::geom_hline(yintercept = 0,
                        linetype = "dashed"),
    ggplot2::labs(
      title = "Residuals vs Fitted",
      x = "Fitted values",
      y = "Residuals"
    )
    )
}
