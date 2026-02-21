# list_model_classes

Returns the possible model classes that \`gglm\` works with.

## Usage

``` r
list_model_classes(...)
```

## Arguments

- ...:

  Currently ignored. For extendability.

## Value

A character vector containing the possible model classes that \`gglm\`
works with.

## Note

Note that these are not always the exact name of the class that that can
be used. This is due to how some methods are written in the packages
\`gglm\` imports. For example, the model class "merMod" refers to a
variety of model outputs from \`lme4\`, even when the outputted class is
not called "merMod".

## Examples

``` r
list_model_classes()
#>  [1] "Mclust"        "NULL"          "Sarlm"         "betamfx"      
#>  [5] "betareg"       "brmsfit"       "clm"           "clmm"         
#>  [9] "coxph"         "data.frame"    "decomposed.ts" "default"      
#> [13] "drc"           "factanal"      "felm"          "fixest"       
#> [17] "gam"           "gamm4"         "glm"           "glmRob"       
#> [21] "glmmTMB"       "glmmadmb"      "glmrob"        "gls"          
#> [25] "htest"         "ivreg"         "kmeans"        "lm"           
#> [29] "lmRob"         "lme"           "lmrob"         "loess"        
#> [33] "logitmfx"      "margins"       "merMod"        "mfx"          
#> [37] "mjoint"        "mlogit"        "negbinmfx"     "nlrq"         
#> [41] "nls"           "pam"           "plm"           "poLCA"        
#> [45] "poissonmfx"    "polr"          "prcomp"        "probitmfx"    
#> [49] "ranef.mer"     "rlm"           "rma"           "rq"           
#> [53] "rqs"           "sarlm"         "smooth.spline" "speedglm"     
#> [57] "speedlm"       "stl"           "survreg"      
```
