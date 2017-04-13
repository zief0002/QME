require(testthat)
require(QME)

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


# More input testing ------------------------------------------------------
math_char = math
math_char[,-1] = apply(math_char[,-1], 2, as.character)

names(math_char)[3] = "different_from_key"

test_that("QMEtest checks whether test and key have same column names", {
  expect_error(QMEtest(math_char, math_key))
})

math_char = math
math_char[,-1] = apply(math_char[,-1], 2, as.character)

math_char[2, 2] = "other option"

test_that("refine_key catches all response options", {
  refined_key = QME:::refine_key(math_key, math_char)
  expect_true("other option" %in% refined_key$response)
})

test_that("QMEtest ensures that key has the same response options as test", {
  expect_error(QMEtest(math_char, math_key))
  }
)
