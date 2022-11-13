#' Given a list of genes, find the corresponding pTS scores for each gene.
#'
#' @param lstGenes A character vector of gene names.
#'
#' @return Returns a table of size (length of lstGenes) x 2, where each row
#'    contains the gene name and its pTS value (if found).
#'
#' @examples
#'
#' # Example 1:
#' annotatedResult <- annotateCNV(chr = 1, start = 15654424, end = 15680097,
#'                                type = 'DEL', num_copies = 1,
#'                                reference = 'GRCh37')
#' genepTS <- findpTS(annotatedResult$symbol)
#'
#' # Example 2:
#' genepTS <- findpTS(c('ABHD15', 'ABLIM2', 'APOC1'))
#'
#' @export
#' @importFrom

findpTS <- function(lstGenes) {
  pHI_pTS <- readRDS('data/pHaplo_pTriplo_data.rds')
  lstpTS <- pHI_pTS[c('X.gene', 'pTriplo')]

  lstGenes <- cbind(lstGenes)
  colnames(lstGenes)<-c('X.gene')
  result <- merge(lstGenes, lstpTS, by='X.gene', all.x = TRUE)

  colnames(result) <- c('gene', 'pTS')

  return(result)
}

# [END]
