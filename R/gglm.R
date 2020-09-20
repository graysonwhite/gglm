#' @title gglm
#'
#' @description Provides four standard visual model diagnostic plots with `ggplot2`.
#'
#' @param model An object of type `lm` or `glm`
#'
#' @return A a `ggplot2` object for visual diagnostic of model validity.
#' @examples
#' library(patchwork)
#' data(mtcars)
#' m1 <- lm(mpg ~ cyl + disp + hp, data = mtcars)
#' gglm(m1)
#' @export

gglm <- function(model) {
  stopifnot(class(model) %in% c("lm", "glm"))
  ggplot2::theme_set(ggplot2::theme_bw())

  fitted_resid <-
    ggplot2::ggplot(model, ggplot2::aes(x = model$fitted, y = model$resid)) +
    ggplot2::geom_point() +
    ggplot2::geom_hline(yintercept = 0, linetype = "dashed") +
    ggplot2::xlab("Fitted values") +
    ggplot2::ylab("Residuals")

  qq <-
    ggplot2::ggplot(model, ggplot2::aes(sample = model$resid)) +
    ggplot2::geom_point(stat = "qq")

  scale_location <-
    ggplot2::ggplot(model, ggplot2::aes(.fitted, sqrt(abs(.stdresid)))) +
    ggplot2::geom_point(na.rm = TRUE) +
    ggplot2::stat_smooth(method = "loess", se = F) +
    ggplot2::labs(x = "fitted",
                  y = expression(sqrt("|Standardized residuals|")),
                  title = "Scale-Location")

  std_res <- rstandard(model)
  leverage <- hatvalues(model)
  df <- data.frame(leverage, std_res)
  resid_lev <-
    ggplot2::ggplot(data = df, ggplot2::aes(x = leverage, y = std_res)) +
    ggplot2::geom_point(size = 1) +
    ggplot2::geom_smooth(
      method = loess,
      se = FALSE,
      color = "indianred3",
      size = 1
    ) +
    ggplot2::ggtitle("Residual vs. Leverage") +
    ggplot2::labs(y = "Standardized Residuals",
         x = "Leverage")

  (fitted_resid + qq) / (scale_location + resid_lev)
}
