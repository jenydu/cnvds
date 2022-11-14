library(CNVds)

# test scripts for function findpLI, findpHI, and findpTS.
# note that these functions do not check whether the input is a gene, due to
# the amount of variation in gene abbreviations and names. Instead, the user
# should use the function geneNoScores() to check the percent of input that does
# not have scores associated with them (a high percentage is an indication that
# there's something wrong with the input).

test_that("findpLI returns the correct output", {
  input <- c('ABHD15', 'ABLIM2', 'APOC1')
  output <- findpLI(input)

  # Check function returns expected outputs
  expect_identical(ncol(output), 2L)
  expect_identical(nrow(output), length(input))
  expect_identical(output$gene, c('ABHD15', 'ABLIM2', 'APOC1'))
  expect_identical(output$pLI, c(3.5459e-08, 4.5858e-03, 2.1685e-01), tolerance=1e-3)
})

test_that("findpHI returns the correct output", {
  input <- c('ABHD15', 'ABLIM2', 'APOC1')
  output <- findpHI(input)

  # Check function returns expected outputs
  expect_identical(ncol(output), 2L)
  expect_identical(nrow(output), length(input))
  expect_identical(output$gene, c('ABHD15', 'ABLIM2', 'APOC1'))
  expect_identical(output$pHI, c(0.4299647, 0.8841926, 0.4436269), tolerance=1e-7)
})

test_that("findpTS returns the correct output", {
  input <- c('ABHD15', 'ABLIM2', 'APOC1')
  output <- findpTS(input)

  # Check function returns expected outputs
  expect_identical(ncol(output), 2L)
  expect_identical(nrow(output), length(input))
  expect_identical(output$gene, c('ABHD15', 'ABLIM2', 'APOC1'))
  expect_identical(output$pTS, c(0.5994862, 0.2800867, 0.5026188), tolerance=1e-7)
})

# [END]
