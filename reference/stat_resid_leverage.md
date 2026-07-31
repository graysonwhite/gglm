# stat_resid_leverage

Residual vs. leverage plot.

## Usage

``` r
stat_resid_leverage(
  mapping = ggplot2::aes(),
  alpha = 0.5,
  method = "loess",
  se = FALSE,
  linecolor = "steelblue",
  ...
)
```

## Arguments

- mapping:

  Additional aesthetic mappings to add to the layer, e.g. \`aes(color =
  some_var)\`. If \`mapping\` includes a required aesthetic (e.g. \`x\`,
  \`y\`), the supplied value is ignored in favor of the default and a
  warning is issued.

- alpha:

  Adjust transparency of points.

- method:

  Method for fitting the line to the points.

- se:

  Keep standard error bands around line?

- linecolor:

  Color of the line.

- ...:

  Additional arguments passed on to \`geom_point()\`.

## Value

A \`ggplot2\` layer for plotting a fitted vs. residual scatter plot.

## Examples

``` r
data(mtcars)
model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
ggplot2::ggplot(data = model) + stat_resid_leverage()
```
