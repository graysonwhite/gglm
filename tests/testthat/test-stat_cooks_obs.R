library(ggplot2)

mod <- lm(mpg ~ wt, mtcars)
result <- ggplot(data = mod) +
  stat_cooks_obs()

test_that("is a ggplot", {
  expect_s3_class(result, class = "gg", exact = FALSE)
  expect_s3_class(result, class = "ggplot", exact = FALSE)
})