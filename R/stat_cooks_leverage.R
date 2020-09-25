#' @title stat_cooks_leverage
#'
#' @description Cook's Distance vs. Leverage
#'
#' @param alpha Adjust transparency of points.
#' @param method Method for fitting the line to the points.
#' @param se Keep standard error bands around line?
#' @param color Color of the line.
#'
#' @return A `ggplot2` layer for plotting Cook's Distance vs. Leverage.
#' @examples
#' data(mtcars)
#' model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
#' model_tbl <- broom::augment(model)
#' ggplot2::ggplot(data = model_tbl) + stat_cooks_leverage()
#' @export
#' @importFrom rlang .data


stat_cooks_leverage <- function(alpha = 0.5,
                           method = "loess",
                           color = "steelblue",
                           se = FALSE) {
  if(class(.data) %in% c("lm", "glm")) {
    .data <- broom::augment(.data)
  } else {
    .data <- .data
  }
  
  list(
    ggplot2::geom_point(mapping = ggplot2::aes(x = .data$.hat,
                                               y = .data$.cooksd),
                        alpha = alpha),
    ggplot2::geom_smooth(
      mapping = ggplot2::aes(x = .data$.hat,
                             y = .data$.cooksd),
      method = method,
      se = se,
      color = color,
      size = 1,
      formula = "y ~ x"
    ),
    ggplot2::labs(
      title = "Cook's Distance vs. Leverage",
      x = "Leverage",
      y = "Cook's distance"
    ),
    ggplot2::theme_bw()
  )
}
