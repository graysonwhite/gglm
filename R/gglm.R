#' @title gglm
#'
#' @description Provides four standard visual model diagnostic plots with `ggplot2`.
#'
#' @param data A model object.
#' @param mapping Additional aesthetic mappings to add to each layer, e.g.
#' `aes(color = some_var)`.
#' @param theme The theme of the `ggplot`s to be produced.
#' @param ... Additional arguments passed on to each `stat_*()` layer.
#'
#' @return A `ggplot2` object for visual diagnostic of model validity.
#' @examples
#' data(mtcars)
#' m1 <- lm(mpg ~ cyl + disp + hp, data = mtcars)
#' gglm(m1)
#' @export

gglm <- function(data,
                 mapping = ggplot2::aes(),
                 theme = ggplot2::theme_gray(),
                 ...) {
  if (!any(class(data) %in% c("data.frame", "tbl_df", "tbl"))) {
    data <- tryCatch({
      broom::augment(data)
    },
    error = function(cond) {
      tryCatch({
        ggplot2::fortify(data)
      },
      error = function(cond) {
        message(
"It looks like you supplied an object that isn't compatible with `gglm`.
Note that for `gglm` to work, there must be an applicable method from `broom` or
`broom.mixed` to `augment()` the data, or an applicable method from `ggplot2` to
`fortify()` the data.")
        data
      })
    })
  }

  ggplot2::theme_set(theme)

  fitted_resid <-
    ggplot2::ggplot(data) +
    stat_fitted_resid(mapping = mapping, ...)

  qq <-
    ggplot2::ggplot(data) +
    stat_normal_qq(mapping = mapping, ...)

  scale_location <-
    ggplot2::ggplot(data) +
    stat_scale_location(mapping = mapping, ...)

  resid_lev <-
    ggplot2::ggplot(data) +
    stat_resid_leverage(mapping = mapping, ...)

  patchwork::wrap_plots((fitted_resid + qq) / (scale_location + resid_lev),
                        guides = "collect")
}
