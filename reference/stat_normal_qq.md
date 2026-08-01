# stat_normal_qq

Normal QQ plot.

## Usage

``` r
stat_normal_qq(mapping = ggplot2::aes(), alpha = 0.5, ...)
```

## Arguments

- mapping:

  Additional aesthetic mappings to add to the layer, e.g.
  `aes(color = some_var)`. If `mapping` includes a required aesthetic
  (e.g. `x`, `y`), the supplied value is ignored in favor of the default
  and a warning is issued.

- alpha:

  Adjust transparency of points.

- ...:

  Additional arguments passed on to
  [`geom_point()`](https://ggplot2.tidyverse.org/reference/geom_point.html).

## Value

A `ggplot2` layer for plotting a Normal Q-Q plot.

## Examples

``` r
data(mtcars)
model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
ggplot2::ggplot(data = model) + stat_normal_qq()
```
