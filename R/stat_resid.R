#' @title stat_resid
#'
#' @description Visualize the residuals of a model versus their fitted values.
#'
#'
#' @return A a `ggplot2` object for visual diagnostic of model validity.
#' @examples
#' @export

stat_resid <- function() {
  ggplot2::layer(
    geom = "point",
    mapping = aes(x = .fitted, y = .resid),
    stat = "identity",
    position = "identity"
  )
    # ggplot2::geom_hline(yintercept = 0, linetype = "dashed") +
    # ggplot2::xlab("Fitted values") +
    # ggplot2::ylab("Residuals")
}

