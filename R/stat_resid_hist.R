#' @title stat_resid_hist
#'
#' @description Visualize the distribution of the residuals of a model.
#'
#' @param mapping Additional aesthetic mappings to add to the layer, e.g.
#' `aes(fill = some_var)`.
#' If `mapping` includes a required aesthetic (e.g. `x`, `y`), the supplied
#' value is ignored in favor of the default and a warning is issued.
#' @param bins Adjust the number of bins.
#' @param ... Additional arguments passed on to `geom_histogram()`.
#'
#' @return A `ggplot2` layer for plotting a histogram of residuals.
#' @examples
#' data(mtcars)
#' model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
#' ggplot2::ggplot(data = model) + stat_resid_hist()
#' @export
#' @importFrom rlang .data

stat_resid_hist <- function(mapping = ggplot2::aes(),
                            bins = 30,
                            ...) {
  mapping <- merge_required_aes(
    ggplot2::aes(x = .data$.resid),
    mapping
  )

  list(
  ggplot2::geom_histogram(mapping = mapping, bins = bins, ...),
  ggplot2::labs(
    x = "Residuals",
    title = "Residual Histogram"
  )
  )
}
