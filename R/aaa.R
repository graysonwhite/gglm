#' @importFrom broom augment
#' @export
broom::augment

.onLoad <- function(libname, pkgname) {

  broom_methods <- utils::.S3methods("augment", envir = asNamespace("broom"))
  broom.mixed_methods <- utils::.S3methods("augment", envir = asNamespace("broom.mixed"))
  methods_list <- unique(c(broom_methods, broom.mixed_methods))

  for(method in methods_list) {
    class <- gsub("augment.", "", method)
    method_fn <- utils::getS3method(f = "augment", class = class)

    vctrs::s3_register(generic = "ggplot2::fortify",
                       class = class,
                       method = method_fn)
  }
}



