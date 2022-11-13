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
#' genepLI <- findpLI(annotatedResult$symbol)
#'
#' # Example 2:
#' genepLI <- findpLI(c('ABHD5', 'ABLIM2', 'PRAMEF17'))
#' @export
#' @importFrom

findpLI <- function(lstGenes) {
  lstpLI <- readRDS('data/pLI_LOEUF_data.rds')
  lstpLI <- lstpLI[c('gene', 'pLI')]

  ## computation ##

  lstGenes <- cbind(lstGenes)
  colnames(lstGenes)<-c('gene')
  result <- merge(lstGenes, lstpLI, by='gene', all.x = TRUE)

  colnames(result) <- c('gene', 'pLI')

  return(result)
}

# [END]
