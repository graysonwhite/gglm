# gglm

Provides four standard visual model diagnostic plots with `ggplot2`.

## Usage

``` r
gglm(data, mapping = ggplot2::aes(), theme = ggplot2::theme_gray(), ...)
```

## Arguments

- data:

  A model object.

- mapping:

  Additional aesthetic mappings to add to each layer, e.g.
  `aes(color = some_var)`.

- theme:

  The theme of the `ggplot`s to be produced.

- ...:

  Additional arguments passed on to each `stat_*()` layer.

## Value

A `ggplot2` object for visual diagnostic of model validity.

## Examples

``` r
data(mtcars)
m1 <- lm(mpg ~ cyl + disp + hp, data = mtcars)
gglm(m1)
```
