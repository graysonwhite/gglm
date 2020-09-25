#' @title stat_normal_qq
#'
#' @description Normal QQ plot.
#'
#' @param alpha Adjust transparency of points.
#'
#' @return A `ggplot2` layer for plotting a Normal Q-Q plot.
#' @examples
#' data(mtcars)
#' model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
#' model_tbl <- broom::augment(model)
#' ggplot2::ggplot(data = model_tbl) + stat_normal_qq()
#' @export
#' @importFrom rlang .data

stat_normal_qq <- function(alpha = 0.5) {
  list(
      ggplot2::geom_point(mapping = ggplot2::aes(sample = .data$.std.resid),
                          stat = "qq",
                          alpha = alpha),
      ggplot2::labs(
        title = "Normal Q-Q",
        x = "Theoretical Quantiles",
        y = "Standardized Residuals"
      ),
      ggplot2::theme_bw()
  )
}
