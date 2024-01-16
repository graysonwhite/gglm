mod <- lm(mpg ~ wt, mtcars)
result <- gglm(mod)

test_that("is a patchwork'd ggplot", {
  expect_s3_class(result, class = "patchwork", exact = FALSE)
  expect_s3_class(result, class = "gg", exact = FALSE)
  expect_s3_class(result, class = "ggplot", exact = FALSE)
})