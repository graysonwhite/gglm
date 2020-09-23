#' @title stat_scale_location
#'
#' @description Provides four standard visual model diagnostic plots with `ggplot2`.
#'
#' @param model An object of type `lm` or `glm`
#'
#' @return A a `ggplot2` object for visual diagnostic of model validity.
#' @examples
#'
#' @export

stat_scale_location <- function() {
  list(
  ggplot2::layer(
    geom = "point",
    params = list(na.rm = TRUE, alpha = 0.5),
    mapping = ggplot2::aes(x = .data$.fitted,
                           y = sqrt(abs(.data$.std.resid))),
    stat = "identity",
    position = "identity"
  ),
    ggplot2::layer(
      stat = "smooth",
      mapping = ggplot2::aes(x = .data$.fitted,
                             y = sqrt(abs(.data$.std.resid))),
      params = list(method = "loess", se = FALSE, color = "steelblue"),
      position = "identity",
      geom = "line"
    )
  )

}
