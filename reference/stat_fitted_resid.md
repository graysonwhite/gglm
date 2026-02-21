# stat_fitted_resid

\`ggplot2\` layer for plotting a fitted vs. residual scatter plot.

## Usage

``` r
stat_fitted_resid(alpha = 0.5, ...)
```

## Arguments

- alpha:

  Adjust transparency of points.

- ...:

  Currently ignored. For extendability.

## Value

A \`ggplot2\` layer for plotting a fitted vs. residual scatter plot.

## Examples

``` r
data(mtcars)
model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
ggplot2::ggplot(data = model) + stat_fitted_resid()
```
