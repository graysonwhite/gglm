#' @title stat_normal_qq
#'
#' @description Normal QQ plot.
#'
#'
#' @return A a `ggplot2` object for visual diagnostic of model validity.
#' @examples
#' @export

stat_normal_qq <- function() {
  list(
      ggplot2::geom_point(mapping = ggplot2::aes(sample = .data$.std.resid),
                          stat = "qq",
                          alpha = 0.5),
      ggplot2::labs(
        title = "Normal Q-Q",
        x = "Theoretical Quantiles",
        y = "Standardized Residuals"
      ),
      ggplot2::theme_bw()
  )
}
