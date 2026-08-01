#' @title stat_cooks_leverage
#'
#' @description Cook's Distance vs. Leverage
#'
#' @param mapping Additional aesthetic mappings to add to the layer, e.g.
#' \code{aes(color = some_var)}.
#' If \code{mapping} includes a required aesthetic (e.g. \code{x}, \code{y}), the
#' supplied value is ignored in favor of the default and a warning is issued.
#' @param alpha Adjust transparency of points.
#' @param method Method for fitting the line to the points.
#' @param se Keep standard error bands around line?
#' @param linecolor Color of the line.
#' @param ... Additional arguments passed on to \code{geom_point()}.
#'
#' @return A \code{ggplot2} layer for plotting Cook's Distance vs. Leverage.
#' @examples
#' data(mtcars)
#' model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
#' ggplot2::ggplot(data = model) + stat_cooks_leverage()
#' @export
#' @importFrom rlang .data


stat_cooks_leverage <- function(mapping = ggplot2::aes(),
                           alpha = 0.5,
                           method = "loess",
                           linecolor = "steelblue",
                           se = FALSE,
                           ...){
  warn_on_deprecated_color(list(...), "stat_cooks_leverage")

  mapping <- merge_required_aes(
    ggplot2::aes(x = .data$.hat, y = .data$.cooksd),
    mapping
  )

  list(
    ggplot2::geom_point(mapping = mapping, alpha = alpha, ...),
    ggplot2::geom_smooth(
      mapping = ggplot2::aes(x = .data$.hat,
                             y = .data$.cooksd),
      method = method,
      se = se,
      color = linecolor,
      linewidth = 1,
      formula = "y ~ x"
    ),
    ggplot2::labs(
      title = "Cook's Distance vs. Leverage",
      x = "Leverage",
      y = "Cook's distance"
    )
  )
}
