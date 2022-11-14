library(CNVds)
# test scripts for function geneDSscores and genesNoScores.

test_that("geneDSscores returns the correct output", {
  input <- 'CHD8'
  output <- geneDSscores(input)

  # Check function returns expected outputs
  expect_identical(ncol(output), 3L)
  expect_identical(nrow(output), 1L)
  expect_identical(output$pLI, 1)
  expect_identical(output$pHI, 0.99164960053, tolerance = 1e-6)
  expect_identical(output$pTS, 0.999999987, tolerance = 1e-6)

  # Incorrect number of inputs
  expect_error(output <- geneDSscores())
  expect_error(output <- geneDSscores('a', 'b'))
})

test_that("genesNoScores returns the correct output", {
  # example consisting of all genes
  input <- c('ABHD15', 'ABLIM2', 'APOC1')
  output <- genesNoScores(input, 'pHI')

  # empty output since all genes should have scores associated.
  expect_identical(output, character(0))

  # example consisting of non-gene inputs
  input2 <- c('NotAGene1', 'NotAGene2', 'APOC1')
  output2 <- genesNoScores(input2, 'pHI')

  expect_identical(length(output2), 2L)

  # incorrect number of inputs
  expect_error(output <- genesNoScores(input2))
})

# [END]
