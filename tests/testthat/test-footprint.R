require(testthat)

data(math)
data(math_key)

test_that("odin_zeus runs without errors", {
  oz = analyze(math, math_key)
print("yo")
  })

test_that("Is the key a valid dataframe", {
  goodkey = data.frame(response = c("A","B","C"),
                           Q1 = c(1,0,0),
                           Q2 = c(0,NA,1),
                           Q3 = c(0, .5, 1))
  badkey = data.frame(response = c("A","B","C"),
                      Q1 = c(1,0,"bum"),
                      Q2 = c(0,NA,1),
                      Q3 = c(0, .5, 1))
    expect_true(is_valid_key(goodkey))
    expect_false(is_valid_key(badkey))
    expect_false(TRUE)
    expect_true(FALSE)
})

test_that("Convert key vector into key dataframe")
