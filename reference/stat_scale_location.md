# stat_scale_location

Scale location diagnostic plot.

## Usage

``` r
stat_scale_location(
  mapping = ggplot2::aes(),
  alpha = 0.5,
  na.rm = TRUE,
  se = FALSE,
  method = "loess",
  linecolor = "steelblue",
  ...
)
```

## Arguments

- mapping:

  Additional aesthetic mappings to add to the layer, e.g.
  `aes(color = some_var)`. If `mapping` includes a required aesthetic
  (e.g. `x`, `y`), the supplied value is ignored in favor of the default
  and a warning is issued.

- alpha:

  Adjust the transparency of points.

- na.rm:

  Remove points with value NA?

- se:

  Keep standard error bands around line?

- method:

  Method for fitting the line to the points.

- linecolor:

  Color of the line.

- ...:

  Additional arguments passed on to
  [`geom_point()`](https://ggplot2.tidyverse.org/reference/geom_point.html).

## Value

A `ggplot2` layer for plotting the scale location diagnostic plot.

## Examples

``` r
data(mtcars)
model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
ggplot2::ggplot(data = model) + stat_scale_location()
```
