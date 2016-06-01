require(testthat)
require(QME)

data(math)
data(math_key)

math_qt = QMEtest(math, math_key)
oz = analyze(math, math_key)

two_cols = data.frame(id = 1:3, item1 = c(TRUE, FALSE, FALSE),
                      item2 = c(FALSE, TRUE, FALSE))
two_cols_key = c(TRUE, TRUE)

test_that("deleted alpha intelligently handles small datasets", {
  expect_silent(analyze(two_cols, two_cols_key))
})
