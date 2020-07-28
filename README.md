# gglm

## Overview

`gglm` is a `ggplot2` extension for easy diagonostic ggplots of generalized linear models that adhere to the Grammar of Graphics. 

## Installation 

```{r eval = FALSE}
# Currently, the best way to install is from GitHub.
devtools::install_github("graysonwhite/gglm")
```

## Functions:

`gglm()` plots the four default diagnostic plots when supplied a glm. This function works similarly to `plot.lm()`, except that it displays the four diagnostic plots at once.

`stat_qq()` produces a normal Q-Q plot. This function is ported directly from `ggplot2`. 

`stat_resid()` produces a fitted vs. residual plot. 

`stat_normal_resid()` produces a histogram of the distribution of the residuals. Alternatively you can specify `geom = density` for a density plot.

`stat_scale_location()`

`stat_cook()` vs. row labels and vs. leverage/(1-leverage)

`stat_resid_leverage()`
