#' @title stat_resid_hist
#'
#' @description Visualize the distribution of the residuals of a model.
#'
#' @param bins Adjust the number of bins.
#' @param ... Currently ignored. For extendability.
#'
#' @return A `ggplot2` layer for plotting a histogram of residuals.
#' @examples
#' data(mtcars)
#' model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
#' ggplot2::ggplot(data = model) + stat_resid_hist()
#' @export
#' @importFrom rlang .data

stat_resid_hist <- function(bins = 30,
                            ...) {
  list(
  ggplot2::geom_histogram(mapping = ggplot2::aes(x = .data$.resid),
                          bins = bins),
  ggplot2::labs(
    x = "Residuals",
    title = "Residual Histogram"
  )
  )
}

