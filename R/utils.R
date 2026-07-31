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


