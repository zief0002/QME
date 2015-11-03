
require(testthat)

data(math)
data(math_key)

test_that("analyze runs without errors", {
  oz = analyze(math, math_key)
})
