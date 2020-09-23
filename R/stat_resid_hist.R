#' @title stat_resid_hist
#'
#' @description Visualize the distribution of the residuals of a model.
#'
#'
#' @return A a `ggplot2` object for visual diagnostic of model validity.
#' @examples
#' @export

stat_resid_hist <- function(bins = 30) {
  list(
  ggplot2::geom_histogram(mapping = ggplot2::aes(x = .data$.resid),
                          bins = bins),
  ggplot2::labs(
    x = "Residuals",
    title = "Residual Histogram"
  ),
  ggplot2::theme_bw()
  )
}

