# stat_resid_leverage

Residual vs. leverage plot.

## Usage

``` r
stat_resid_leverage(
  alpha = 0.5,
  method = "loess",
  se = FALSE,
  linecolor = "steelblue",
  ...
)
```

## Arguments

- alpha:

  Adjust transparency of points.

- method:

  Method for fitting the line to the points.

- se:

  Keep standard error bands around line?

- linecolor:

  Color of the line.

- ...:

  Additional arguments to be passed to the \`aes()\` in
  \`geom_point()\`.

## Value

A \`ggplot2\` layer for plotting a fitted vs. residual scatter plot.

## Examples

``` r
data(mtcars)
model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
ggplot2::ggplot(data = model) + stat_resid_leverage()
```
