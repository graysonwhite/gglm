#' @title list_model_classes
#'
#' @description Returns the possible model classes that `gglm` works with.
#'
#' @param ... Currently ignored. For extendability.
#' @note Note that these are not always the exact name of the class that that 
#' can be used. This is due to how some methods are written in the packages
#' `gglm` imports. For example, the model class "merMod" refers to a variety of
#' model outputs from `lme4`, even when the outputted class is not called 
#' "merMod". 
#' @return A character vector containing the possible model classes that `gglm`
#' works with.
#' @examples
#' list_model_classes()
#' @export

list_model_classes <- function(...) {
  ns <- getNamespace("gglm")
  model_classes <- c()
  for (i in names(ns)) {
    if (startsWith(i, "fortify.")) {
      class <- gsub("fortify.", "", i)
      model_classes <- c(model_classes, class)
    }
  }
  return(model_classes)
}
