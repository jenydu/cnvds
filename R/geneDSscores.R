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
#' @importFrom

geneDSscores <- function(gene) {
  pHI_pTS <- readRDS('pHaplo_pTriplo_data.rds')
  pLI <- readRDS('pLI_LOEUF_data.rds')

  gene_row = pHI_pTS[which(pHI_pTS$X.gene==gene),]
  pHI <- gene_row[2]
  pTS <- gene_row[3]

  pLI <- pLI[which(pLI$gene==gene),][2]

  result <- matrix(nrow = 1, ncol = 3)
  result[1,] <- c(pHI, pTS, pLI)
  colnames(result) <- c('pLI', 'pHI', 'pTS')

  return(result)
}

# [END]
