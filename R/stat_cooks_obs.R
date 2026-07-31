#' @title stat_cooks_obs
#'
#' @description `ggplot2` layer for plotting cook's distance by observation number.
#'
#' @param mapping Additional aesthetic mappings to add to the layer, e.g.
#' `aes(fill = some_var)`.
#' If `mapping` includes a required aesthetic (e.g. `x`, `y`), the supplied
#' value is ignored in favor of the default and a warning is issued.
#' @param ... Additional arguments passed on to `geom_col()`.
#'
#' @return A `ggplot2` layer for plotting cook's distance by observation number.
#' @examples
#' data(mtcars)
#' model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
#' ggplot2::ggplot(data = model) + stat_cooks_obs()
#' @export
#' @importFrom rlang .data

stat_cooks_obs <- function(mapping = ggplot2::aes(), ...) {
  mapping <- merge_required_aes(
    ggplot2::aes(x = 1:length(.data$.resid), y = .data$.cooksd),
    mapping
  )

  list(
    ggplot2::geom_col(mapping = mapping, ...),
    ggplot2::labs(title = "Cook's Distance",
                  x = "Observation Number",
                  y = "Cook's Distance")
  )
}
