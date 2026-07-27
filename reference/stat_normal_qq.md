# stat_normal_qq

Normal QQ plot.

## Usage

``` r
stat_normal_qq(alpha = 0.5, ...)
```

## Arguments

- alpha:

  Adjust transparency of points.

- ...:

  Additional arguments to be passed to the \`aes()\` of \`stat_qq()\`.
  These arguments correspond to the aesthetics of the points on the
  plot.

## Value

A \`ggplot2\` layer for plotting a Normal Q-Q plot.

## Examples

``` r
data(mtcars)
model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
ggplot2::ggplot(data = model) + stat_normal_qq()
```
