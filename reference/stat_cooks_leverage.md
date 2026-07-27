# stat_cooks_leverage

Cook's Distance vs. Leverage

## Usage

``` r
stat_cooks_leverage(
  alpha = 0.5,
  method = "loess",
  linecolor = "steelblue",
  se = FALSE,
  ...
)
```

## Arguments

- alpha:

  Adjust transparency of points.

- method:

  Method for fitting the line to the points.

- linecolor:

  Color of the line.

- se:

  Keep standard error bands around line?

- ...:

  Additional arguments to be passed to the \`aes()\` in
  \`geom_point()\`.

## Value

A \`ggplot2\` layer for plotting Cook's Distance vs. Leverage.

## Examples

``` r
data(mtcars)
model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
ggplot2::ggplot(data = model) + stat_cooks_leverage()
```
