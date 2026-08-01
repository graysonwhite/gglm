# list_model_classes

Returns the possible model classes that `gglm` works with.

## Usage

``` r
list_model_classes(...)
```

## Arguments

- ...:

  Currently ignored. For extendability.

## Value

A character vector containing the possible model classes that `gglm`
works with.

## Note

Note that these are not always the exact name of the class that that can
be used. This is due to how some methods are written in the packages
`gglm` imports. For example, the model class "merMod" refers to a
variety of model outputs from `lme4`, even when the outputted class is
not called "merMod".

## Examples

``` r
list_model_classes()
#>  [1] "Mclust"        "Sarlm"         "betamfx"       "betareg"      
#>  [5] "brmsfit"       "clm"           "clmm"          "coxph"        
#>  [9] "decomposed.ts" "drc"           "factanal"      "felm"         
#> [13] "fixest"        "gam"           "gamm4"         "glm"          
#> [17] "glmRob"        "glmmTMB"       "glmmadmb"      "glmrob"       
#> [21] "gls"           "htest"         "ivreg"         "kmeans"       
#> [25] "lm"            "lmRob"         "lme"           "lmrob"        
#> [29] "loess"         "logitmfx"      "margins"       "merMod"       
#> [33] "mfx"           "mjoint"        "mlogit"        "negbinmfx"    
#> [37] "nlrq"          "nls"           "pam"           "plm"          
#> [41] "poLCA"         "poissonmfx"    "polr"          "prcomp"       
#> [45] "probitmfx"     "ranef.mer"     "rlm"           "rma"          
#> [49] "rq"            "rqs"           "sarlm"         "smooth.spline"
#> [53] "speedglm"      "speedlm"       "stl"           "survreg"      
```
