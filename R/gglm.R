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
    ggplot2::ggplot(model,
                    mapping = ggplot2::aes(x = model$fitted,
                                           y = model$resid)) +
    ggplot2::geom_point() +
    ggplot2::geom_hline(yintercept = 0,
                        linetype = "dashed") +
    ggplot2::labs(
      title = "Residuals vs Fitted",
      x = "Fitted values",
      y = "Residuals"
    )

  qq <-
    ggplot2::ggplot(model, ggplot2::aes(sample = model$resid)) +
    ggplot2::geom_point(stat = "qq") +
    ggplot2::labs(
      title = "Normal Q-Q",
      x = "Theoretical Quantiles",
      y = "Standardized Residuals"
    )

  scale_location <-
    ggplot2::ggplot(model, ggplot2::aes(x = model$fitted,
                                        y = sqrt(abs(MASS::stdres(model))))) +
    ggplot2::geom_point(na.rm = TRUE) +
    ggplot2::stat_smooth(method = "loess",
                         se = F,
                         color = "steelblue") +
    ggplot2::labs(x = "Fitted values",
                  y = expression(sqrt("|Standardized residuals|")),
                  title = "Scale-Location")

  std_res <- stats::rstandard(model)
  leverage <- stats::hatvalues(model)
  df <- data.frame(leverage, std_res)
  resid_lev <-
    ggplot2::ggplot(data = df,
                    mapping = ggplot2::aes(x = leverage, y = std_res)) +
    ggplot2::geom_point() +
    ggplot2::geom_smooth(
      method = "loess",
      se = FALSE,
      color = "steelblue",
      size = 1
    ) +
    ggplot2::labs(title = "Residual vs. Leverage",
                  y = "Standardized Residuals",
                  x = "Leverage")

  (fitted_resid + qq) / (scale_location + resid_lev)
}
