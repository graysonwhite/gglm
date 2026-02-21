# stat_scale_location

Scale location diagnostic plot.

## Usage

``` r
stat_scale_location(
  alpha = 0.5,
  na.rm = TRUE,
  se = FALSE,
  method = "loess",
  color = "steelblue",
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

- color:

  Color of the line.

- ...:

  Currently ignored. For extendability.

## Value

A \`ggplot2\` layer for plotting the scale location diagnostic plot.

## Examples

``` r
data(mtcars)
model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
ggplot2::ggplot(data = model) + stat_scale_location()
```
