# launch

Launches a R Shiny-based applet for linear model diagnostics.

## Usage

``` r
launch(
  data = NULL,
  example_datasets = list(penguins = palmerpenguins::penguins, candy =
    fivethirtyeight::candy_rankings, mtcars = datasets::mtcars),
  ...
)
```

## Arguments

- data:

  A `data.frame` to use in modeling. Meant for one-off uses of
  `launch()` with data in your working environment.

- example_datasets:

  A named `list` of example datasets to use in modeling. Meant for
  publicly hosting instances of `launch()` with a set of preferred
  datasets.

- ...:

  Currently ignored. For extendability.

## Value

None. Launches a `shiny` applet for point-and-click based model
diagnostics.

## Examples

``` r
if (FALSE) { # \dontrun{
launch()
} # }
```
