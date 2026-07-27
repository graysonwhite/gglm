#' @title stat_cooks_leverage
#'
#' @description Cook's Distance vs. Leverage
#'
#' @param alpha Adjust transparency of points.
#' @param method Method for fitting the line to the points.
#' @param se Keep standard error bands around line?
#' @param linecolor Color of the line.
#' @param ... Additional arguments to be passed to the `aes()` in `geom_point()`.
#'
#' @return A `ggplot2` layer for plotting Cook's Distance vs. Leverage.
#' @examples
#' data(mtcars)
#' model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
#' ggplot2::ggplot(data = model) + stat_cooks_leverage()
#' @export
#' @importFrom rlang .data


stat_cooks_leverage <- function(alpha = 0.5,
                           method = "loess",
                           linecolor = "steelblue",
                           se = FALSE,
                           ...){
  list(
    ggplot2::geom_point(mapping = ggplot2::aes(x = .data$.hat,
                                               y = .data$.cooksd,
                                               ... = ...),
                        alpha = alpha),
    ggplot2::geom_smooth(
      mapping = ggplot2::aes(x = .data$.hat,
                             y = .data$.cooksd),
      method = method,
      se = se,
      color = linecolor,
      size = 1,
      formula = "y ~ x"
    ),
    ggplot2::labs(
      title = "Cook's Distance vs. Leverage",
      x = "Leverage",
      y = "Cook's distance"
    )
  )
}
