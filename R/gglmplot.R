#' @title gglmplot
#'
#' @description Provides visual model diagnostic plots with `ggplot2`.
#'
#' @param model An object of type `lm` or `glm`
#' @param type Type of plot to be returned ("fitted_resid", "resid_hist", "qq", "scale_location")
#'
#' @return A a `ggplot2` object for visual diagnostic of model validity.
#' @examples
#' data(mtcars)
#' m1 <- lm(mpg ~ cyl + disp + hp, data = mtcars)
#' gglmplot(m1, type = "qq")
#' @export

gglmplot <- function(model, type) {
  types <- c("fitted_resid", "resid_hist", "qq", "scale_location")
  stopifnot(class(model) %in% c("lm", "glm"),
            type %in% types)

  if (type == "fitted_resid") {
    ggplot2::ggplot(model, ggplot2::aes(x = .fitted, y = .resid)) +
      ggplot2::geom_point() +
      ggplot2::geom_hline(yintercept = 0, linetype = "dashed") +
      ggplot2::xlab("Fitted values") +
      ggplot2::ylab("Residuals")
  } else if (type == "resid_hist") {
    ggplot2::ggplot(model, ggplot2::aes(x = .resid)) +
      ggplot2::geom_histogram(binwidth = 25) +
      ggplot2::xlab("Residuals")
  } else if (type == "qq") {
    ggplot2::ggplot(model, ggplot2::aes(sample = .resid)) +
      ggplot2::geom_point(stat = "qq")
  } else if (type == "scale_location") {
    ggplot2::ggplot(model, ggplot2::aes(x = .fitted, y = sqrt(abs(.stdresid)))) +
      ggplot2::geom_point(na.rm = TRUE) +
      ggplot2::stat_smooth(method = "glm") +
      ggplot2::labs(x = "fitted",
                    y = expression(sqrt("|Standardized residuals|")),
                    title = "Scale-Location")
  }
  else {
    stop()
  }
}
