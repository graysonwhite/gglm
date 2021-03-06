% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stat_resid_leverage.R
\name{stat_resid_leverage}
\alias{stat_resid_leverage}
\title{stat_resid_leverage}
\usage{
stat_resid_leverage(
  alpha = 0.5,
  method = "loess",
  se = FALSE,
  color = "steelblue",
  ...
)
}
\arguments{
\item{alpha}{Adjust transparency of points.}

\item{method}{Method for fitting the line to the points.}

\item{se}{Keep standard error bands around line?}

\item{color}{Color of the line.}

\item{...}{Currently ignored. For extendability.}
}
\value{
A `ggplot2` layer for plotting a fitted vs. residual scatter plot.
}
\description{
Residual vs. leverage plot.
}
\examples{
data(mtcars)
model <- lm(mpg ~ cyl + disp + hp, data = mtcars)
ggplot2::ggplot(data = model) + stat_resid_leverage()
}
