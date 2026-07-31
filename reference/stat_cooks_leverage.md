# stat_cooks_leverage

Cook's Distance vs. Leverage

## Usage

``` r
stat_cooks_leverage(
  mapping = ggplot2::aes(),
  alpha = 0.5,
  method = "loess",
  linecolor = "steelblue",
  se = FALSE,
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

- linecolor:

  Color of the line.

- se:

  Keep standard error bands around line?

- ...:

  Additional arguments passed on to \`geom_point()\`.

## Value

A \`ggplot2\` layer for plotting Cook's Distance vs. Leverage.

## Examples

``` r
data(mtcars)
model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
ggplot2::ggplot(data = model) + stat_cooks_leverage()
```
