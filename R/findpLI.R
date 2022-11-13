#' Given a list of genes, find the corresponding pLI scores for each gene.
#'
#' @param lstGenes A character vector of gene names.
#'
#' @return Returns a table of size (length of lstGenes) x 2, where each row
#'    contains the gene name and its pLI value (if found).
#'
#' @examples
#'
#' # Example 1:
#' annotatedResult <- annotateCNV(chr = 1, start = 15654424, end = 15680097,
#'                                type = 'DEL', num_copies = 1,
#'                                reference = 'GRCh37')
#' lstpLI <- findpLI(annotatedResult$symbol)
#'
#' # Example 2:
#' lstpLI <- findpLI(c('ABHD5', 'ABLIM2'))
#' @export
#' @importFrom

findpLI <- function(lstGenes) {
  lstpLI <- readRDS('data/pLI_LOEUF_data.rds')


  ## computation ##
  result <- as.data.frame(matrix(nrow = length(lstGenes), ncol = 2))
  for (i in seq_along(lstGenes)) {

    pLI <-lstpLI[which(lstpLI$gene == lstGenes[i]),]
    if (nrow(pLI) == 0) {
      pLI <- -1
    } else {
      pLI <- pLI[,2]
    }
    result[i,] <- c(lstGenes[i], pLI)
  }

  colnames(result) <- c('gene', 'pLI')
  return(result)
}

# [END]
