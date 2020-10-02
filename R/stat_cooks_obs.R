#' @title stat_cooks_obs
#'
#' @description `ggplot2` layer for plotting cook's distance by observation number.
#'
#' @param ... Currently ignored. For extendability.
#'
#' @return A `ggplot2` layer for plotting cook's distance by observation number.
#' @examples
#' data(mtcars)
#' model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
#' ggplot2::ggplot(data = model) + stat_cooks_obs()
#' @export
#' @importFrom rlang .data

stat_cooks_obs <- function(...) {
  list(
    ggplot2::geom_col(mapping = ggplot2::aes(x = 1:length(.data$.resid),
                                             y = .data$.cooksd)),
    ggplot2::labs(title = "Cook's Distance",
                  x = "Observation Number",
                  y = "Cook's Distance")
  )
}
