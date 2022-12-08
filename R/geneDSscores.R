#' Find pLI, pHI, pTS Scores of a Gene
#'
#' Given a single gene symbol, find its associated pLI, pHI, and pTS scores.
#'
#' Probability of loss intolerance (pLI) is the probability that a gene is intolerant to a loss of function mutation.
#' Probability of haploinsufficiency (pHI) is the probability that a gene is sensitive to copy number loss.
#' Probability of triplosensitivity (pTS) is the probability that the gene is sensitive to copy number gain.
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
