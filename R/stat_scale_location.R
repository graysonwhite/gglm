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
  ggplot2::ggplot(mapping = ggplot2::aes(x = model$fitted,
                                         y = sqrt(abs(MASS::stdres(model))))) +
    ggplot2::geom_point(na.rm = TRUE,
                        alpha = 0.5) +
    ggplot2::stat_smooth(method = "loess",
                         se = F,
                         color = "steelblue") +
    ggplot2::labs(x = "Fitted values",
                  y = expression(sqrt("|Standardized residuals|")),
                  title = "Scale-Location")
}
