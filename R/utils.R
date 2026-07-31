# quiet R-CMD-check NOTEs that workflowsets and yardstick are unused
# (see example data .Rmds for usage)
#' @importFrom broom.mixed tidyMCMC
#' @importFrom ggplot2 ggplot
NULL

merge_required_aes <- function(required, mapping) {
  ignored <- intersect(names(required), names(mapping))
  if (length(ignored) > 0) {
    warning(
      "The following user-supplied aesthetic(s) conflict with required aesthetic(s) and will be ignored: ",
      paste(ignored, collapse = ", "),
      call. = FALSE
    )
  }
  utils::modifyList(mapping, required)
}

warn_on_deprecated_color <- function(dots, fn_name) {
  if ("color" %in% names(dots)) {
    warning(
      "In `", fn_name, "()`, `color` no longer sets the trend line color; ",
      "use `linecolor` instead. The `color` value you supplied has been ",
      "passed on to `geom_point()` and will set the point color.",
      call. = FALSE
    )
  }
}

qq_theoretical_quantiles <- function(resid) {
  std_resid <- resid / stats::sd(resid)
  theoretical <- stats::qnorm(stats::ppoints(base::length(std_resid)))
  theoretical[order(order(std_resid))]
}

utils::globalVariables(c(
  ".",
  ".rownames",
  ":=",
  "QE.del",
  "alternative",
  "chosen",
  "cook.d",
  "cov.r",
  "dfbetas",
  "dffits",
  "hat",
  "id",
  "linpred",
  "probabilities",
  "rstudent",
  "tau2.del",
  "weight"
))


