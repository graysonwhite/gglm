#' @title stat_fitted_resid
#'
#' @description Provides four standard visual model diagnostic plots with `ggplot2`.
#'
#' @param model An object of type `lm` or `glm`
#'
#' @return A a `ggplot2` object for visual diagnostic of model validity.
#' @examples
#'
#' @export

stat_fitted_resid <- function() {
  list(
    ggplot2::geom_point(mapping = ggplot2::aes(x = .data$.fitted,
                                               y = .data$.resid),
                        alpha = 0.5),
    ggplot2::geom_hline(yintercept = 0,
                        linetype = "dashed"),
    ggplot2::labs(
      title = "Residuals vs Fitted",
      x = "Fitted values",
      y = "Residuals"
    ),
    ggplot2::theme_bw()
    )
}
