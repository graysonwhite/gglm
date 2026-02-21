# stat_cooks_obs

\`ggplot2\` layer for plotting cook's distance by observation number.

## Usage

``` r
stat_cooks_obs(...)
```

## Arguments

- ...:

  Currently ignored. For extendability.

## Value

A \`ggplot2\` layer for plotting cook's distance by observation number.

## Examples

``` r
data(mtcars)
model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
ggplot2::ggplot(data = model) + stat_cooks_obs()
```
