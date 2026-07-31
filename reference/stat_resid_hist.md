# stat_resid_hist

Visualize the distribution of the residuals of a model.

## Usage

``` r
stat_resid_hist(mapping = ggplot2::aes(), bins = 30, ...)
```

## Arguments

- mapping:

  Additional aesthetic mappings to add to the layer, e.g. \`aes(fill =
  some_var)\`. If \`mapping\` includes a required aesthetic (e.g. \`x\`,
  \`y\`), the supplied value is ignored in favor of the default and a
  warning is issued.

- bins:

  Adjust the number of bins.

- ...:

  Additional arguments passed on to \`geom_histogram()\`.

## Value

A \`ggplot2\` layer for plotting a histogram of residuals.

## Examples

``` r
data(mtcars)
model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
ggplot2::ggplot(data = model) + stat_resid_hist()
```
