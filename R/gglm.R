#' @title gglm
#'
#' @description Provides four standard visual model diagnostic plots with `ggplot2`.
#'
#' @param data A model object of type `lm` or `glm`.
#' @param theme The theme of the `ggplot`s to be produced.
#' @param ... Currently ignored. For extendability.
#'
#' @return A a `ggplot2` object for visual diagnostic of model validity.
#' @examples
#' data(mtcars)
#' m1 <- lm(mpg ~ cyl + disp + hp, data = mtcars)
#' gglm(m1)
#' @export

gglm <- function(data,
                 theme = ggplot2::theme_gray(),
                 ...) {
  if (!any(class(data) %in% c("data.frame", "tbl_df", "tbl"))) {
    tryCatch({
      fortify(data)
    },
    error = function(cond) {
      message(
"It looks like you supplied an object that isn't compatible with `gglm`. 
Note that for `gglm` to work, there must be an applicable method from `broom` or
`broom.mixed` to `augment()` the data, or an applicable method from `ggplot2` to
`fortify()` the data.")
    })
  }
  
  ggplot2::theme_set(theme)

  fitted_resid <-
    ggplot2::ggplot(data) +
    stat_fitted_resid()
  
  qq <-
    ggplot2::ggplot(data) +
    stat_normal_qq()
  
  scale_location <-
    ggplot2::ggplot(data) +
    stat_scale_location()
  
  resid_lev <-
    ggplot2::ggplot(data) +
    stat_resid_leverage()
  
  patchwork::wrap_plots((fitted_resid + qq) / (scale_location + resid_lev))
}
