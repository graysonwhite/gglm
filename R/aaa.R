#' @importFrom broom augment
#' @export
broom::augment

.onLoad <- function(libname, pkgname) {

  broom_methods <- utils::.S3methods("augment", envir = asNamespace("broom"))
  broom.mixed_methods <- utils::.S3methods("augment", envir = asNamespace("broom.mixed"))
  methods_list <- unique(c(broom_methods, broom.mixed_methods))

  methods_list <- setdiff(methods_list,
                          c("augment.data.frame", "augment.default", "augment.NULL"))

  for(method in methods_list) {
    class <- gsub("augment.", "", method)
    method_fn <- utils::getS3method(f = "augment", class = class)

    vctrs::s3_register(generic = "ggplot2::fortify",
                       class = class,
                       method = method_fn)

    vctrs::s3_register(generic = "ggplot2::ggplot",
                       class = class,
                       method = ggplot_method(method_fn))
  }
}

ggplot_method <- function(augment_fn) {
  force(augment_fn)
  function(data, mapping = ggplot2::aes(), ..., environment = parent.frame()) {
    ggplot2::ggplot(data = augment_fn(data),
                    mapping = mapping,
                    ... = ...,
                    environment = environment)
  }
}



