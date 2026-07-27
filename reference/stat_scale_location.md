# stat_scale_location

Scale location diagnostic plot.

## Usage

``` r
stat_scale_location(
  alpha = 0.5,
  na.rm = TRUE,
  se = FALSE,
  method = "loess",
  linecolor = "steelblue",
  ...
)
```

## Arguments

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

  Additional arguments to be passed to the \`aes()\` in
  \`geom_point()\`.

## Value

A \`ggplot2\` layer for plotting the scale location diagnostic plot.

## Examples

``` r
data(mtcars)
model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
ggplot2::ggplot(data = model) + stat_scale_location()
```
