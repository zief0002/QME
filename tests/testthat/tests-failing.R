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


response_test = data.frame(id = 1:3, item1 = c(TRUE, FALSE, FALSE),
                          item2 = c(FALSE, TRUE, FALSE),
                          item3 = TRUE)
response_key = c(TRUE, TRUE, TRUE)

response_qt = QMEtest(response_test, response_key)

test_that("refine key includes all possible response options", {
  goodkey = data.frame(response = c("TRUE", "FALSE"), item1 = c(1, 0), 
                 item2 = c(1, 0), item3 = c(1, 0), stringsAsFactors = FALSE)
  expect_equal(goodkey[order(goodkey$response),],
               response_qt$key[order(response_qt$key$response), ])
      })
  

