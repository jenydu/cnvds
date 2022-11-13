#' Given a list of genes, find the corresponding pHI scores for each gene.
#'
#' @param lstGenes A character vector of gene names.
#'
#' @return Returns a table of size (length of lstGenes) x 2, where each row
#'    contains the gene name and its pHI value (if found).
#'
#' @examples
#'
#' # Example 1:
#' annotatedResult <- annotateCNV(chr = 1, start = 15654424, end = 15680097,
#'                                type = 'DEL', num_copies = 1,
#'                                reference = 'GRCh37')
#' genepHI <- findpHI(annotatedResult$symbol)
#'
#' # Example 2:
#' genepHI <- findpHI(c('ABHD15', 'ABLIM2', 'APOC1'))
#'
#' @export
#' @importFrom

findpHI <- function(lstGenes) {
  pHI_pTS <- readRDS('data/pHaplo_pTriplo_data.rds')
  lstpHI <- pHI_pTS[c('X.gene', 'pHaplo')]

  ## computation ##
  result <- as.data.frame(matrix(nrow = length(lstGenes), ncol = 2))
  for (i in seq_along(lstGenes)) {
    pHI <-lstpHI[which(lstpHI$X.gene == lstGenes[i]),]
    if (nrow(pHI) == 0) {
      pHI <- -1
    } else {
      pHI <- pHI[,2]
    }
    result[i,] <- c(lstGenes[i], pHI)
  }

  colnames(result) <- c('gene', 'pHI')
  return(result)
}

# [END]
