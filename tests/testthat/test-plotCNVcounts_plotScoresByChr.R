library(CNVds)
# test scripts for function plotCNVcounts and plotScoresByChr. Mainly checks
# that incorrect input values are correctly catched.

test_that("plotCNVcounts correctly rejects incorrect inputs", {
  CNVinput <- data.frame(c(1, 1, 2, 3),
                         c(12312, 293012, 3829103, 3281901),
                         c(23423, 402405, 4025002, 8531273),
                         c('Deletion', 'Duplication', 'DEL', 'DEL'))
  # incorrect type format (should be either 'DUP' or 'DEL')
  expect_error(plotCNVcounts <- plotCNVcounts(CNVinput))

  # incorrect number of columns
  expect_error(plotCNVcounts <- plotCNVcounts(CNVinput[c(1:3)]))
})

test_that("plotScoresByChr correctly rejects incorrect inputs", {
  annotated <- data.frame(c(1, 4, 6, 7),
                          c('geneA', 'geneB', 'geneC', 'geneD'),
                          c(0.7, 0.99, 0.2, 0.5))

  # incorrect number of columns
  expect_error(plotCNVcounts <- plotScoresByChr(annotated[c(1:2)], 'pHI', 0.9))

})

# [END]
