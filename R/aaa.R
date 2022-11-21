#' @importFrom broom augment
#' @export
broom::augment

fortify <- function (x, ...) {
  UseMethod("fortify")
} 

.onLoad <- function(libname, pkgname) {

  broom_methods <- utils::.S3methods("augment", envir = asNamespace("broom"))
  broom.mixed_methods <- utils::.S3methods("augment", envir = asNamespace("broom.mixed"))
  methods_list <- unique(c(broom_methods, broom.mixed_methods))

  ns <- rlang::ns_env()
  
  for(method in methods_list) {
    class <- gsub("augment.", "", method)
    assign(x = paste("fortify", class, sep = "."),
           value = utils::getS3method(f = "augment",
                                      class = class),
           envir = ns)

    vctrs::s3_register(generic = "ggplot2::fortify",
                       class = class)
  }
}



