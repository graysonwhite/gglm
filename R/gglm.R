#' @title gglm
#'
#' @description Provides four standard visual model diagnostic plots with `ggplot2`.
#'
#' @param model An object of type `lm` or `glm`, or a `broom::augment()`ed tibble from a model object of type `lm` or `glm`.
#' @param theme The theme of the `ggplot`s to be produced.
#'
#' @return A a `ggplot2` object for visual diagnostic of model validity.
#' @examples
#' data(mtcars)
#' m1 <- lm(mpg ~ cyl + disp + hp, data = mtcars)
#' gglm(m1)
#' @export

gglm <- function(model, theme = ggplot2::theme_gray()) {
  stopifnot(class(model) %in% c("lm", "glm", "tbl", "tbl_df", "data.frame"))
  ggplot2::theme_set(theme)
  options(warn = -1)

  if(class(model) %in% c("lm", "glm")) {
    model_df <- broom::augment(model)
  } else {
    model_df <- model
  }

  fitted_resid <-
    ggplot2::ggplot(model_df,
                    mapping = ggplot2::aes(x = model_df$.fitted,
                                           y = model_df$.resid)) +
    ggplot2::geom_point(alpha = 0.5) +
    ggplot2::geom_hline(yintercept = 0,
                        linetype = "dashed") +
    ggplot2::labs(
      title = "Residuals vs Fitted",
      x = "Fitted values",
      y = "Residuals"
    )

  qq <-
    ggplot2::ggplot(model_df, ggplot2::aes(sample = model_df$.resid)) +
    ggplot2::geom_point(stat = "qq",
                        alpha = 0.5) +
    ggplot2::labs(
      title = "Normal Q-Q",
      x = "Theoretical Quantiles",
      y = "Standardized Residuals"
    )

  scale_location <-
    ggplot2::ggplot(model_df, ggplot2::aes(x = model_df$.fitted,
                                        y = sqrt(abs(model_df$.std.resid)))) +
    ggplot2::geom_point(na.rm = TRUE,
                        alpha = 0.5) +
    ggplot2::stat_smooth(method = "loess",
                         se = F,
                         color = "steelblue",
                         formula = "y ~ x") +
    ggplot2::labs(x = "Fitted values",
                  y = expression(sqrt("|Standardized residuals|")),
                  title = "Scale-Location")

  resid_lev <-
    ggplot2::ggplot(data = model_df,
                    mapping = ggplot2::aes(x = model_df$.hat, y = model_df$.std.resid)) +
    ggplot2::geom_point(alpha = 0.5) +
    ggplot2::geom_smooth(
      method = "loess",
      se = FALSE,
      color = "steelblue",
      size = 1,
      formula = "y ~ x"
    ) +
    ggplot2::labs(title = "Residual vs. Leverage",
                  y = "Standardized Residuals",
                  x = "Leverage")

  patchwork::wrap_plots((fitted_resid + qq) / (scale_location + resid_lev))
}
