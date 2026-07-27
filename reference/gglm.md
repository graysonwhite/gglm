# gglm

Provides four standard visual model diagnostic plots with \`ggplot2\`.

## Usage

``` r
gglm(data, theme = ggplot2::theme_gray(), ...)
```

## Arguments

- data:

  A model object of type \`lm\` or \`glm\`.

- theme:

  The theme of the \`ggplot\`s to be produced.

- ...:

  Currently ignored. For extendability.

## Value

A a \`ggplot2\` object for visual diagnostic of model validity.

## Examples

``` r
data(mtcars)
m1 <- lm(mpg ~ cyl + disp + hp, data = mtcars)
gglm(m1)
```
