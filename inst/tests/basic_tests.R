
require(testthat)

data(math)
data(math_key)

test_that("odin_zeus runs without errors", {
  odin_zeus(math, math_key)
})
