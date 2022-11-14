library(CNVds)

test_that("annotateCNV() returns correct outputs", {

  chr <- 1
  start <- 15654424
  end <- 15680097
  type <- 'DEL'
  num_copies <- 1
  reference <- 'GRCh37'

  annotatedResult <- annotateCNV(chr, start, end, type, num_copies, reference)

  # Check function returns expected outputs
  expect_identical(ncol(annotatedResult), 6L)
  expect_identical(annotatedResult$gene, c('TMEM63A', 'DMAP1'))
  expect_identical(annotatedResult$chr, c('1', '1'))
  expect_identical(annotatedResult$start, c(225845536L, 44213455L))
  expect_identical(annotatedResult$end, c(225882380L, 44220681L))
  expect_identical(annotatedResult$type, c('DEL', 'DEL'))
  expect_identical(annotatedResult$copyNumChange, c(1, 1))

  # Incorrect inputs
  # chr must be 1 to 22.
  expect_error(annotatedResult <- annotateCNV(chr = 33, start, end, type,
                                              num_copies, reference))
  # start position cannot be greater than end position.
  expect_error(annotatedResult <- annotateCNV(chr, start = 100, end = 50, type,
                                              num_copies, reference))
  # deletion CNVs cannot have 3 copies.
  expect_error(annotatedResult <- annotateCNV(chr, start, end, type = "DEL",
                                              num_copies = 3, reference))
})
# [END]
