#' Find pLI, pHI, pTS Scores of a Gene
#'
#' Given a single gene symbol, find its associated pLI, pHI, and pTS scores.
#'
#' @param gene A character string that represents a gene symbol.
#'
#' @return Returns a 3x1 table containing the gene's pLI, pHI, and pTS values.
#'
#' @examples
#' geneDSscores <- geneDSscores('CHD8')
#'
#' @export

geneDSscores <- function(gene) {
  pLI_data <- readRDS('~/CNVds/inst/extdata/pLI_data.rds')
  pHaplo_pTriplo_data <- readRDS('~/CNVds/inst/extdata/pHaplo_pTriplo_data.rds')

  gene_row <- pHaplo_pTriplo_data[which(pHaplo_pTriplo_data$X.gene==gene), ]
  pHI <- gene_row[2]
  pTS <- gene_row[3]

  pLI <- pLI_data[which(pLI_data$gene==gene), ][2]

  result <- matrix(nrow = 1, ncol = 3)
  result <- cbind(pLI, pHI, pTS)
  colnames(result) <- c('pLI', 'pHI', 'pTS')

  return(result)
}

# [END]
