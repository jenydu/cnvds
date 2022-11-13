#' Find pTS Scores for a List of Genes
#'
#' Given a list of genes, find the corresponding pTS scores for each gene.
#'
#' @param lstGenes A character vector of gene names.
#'
#' @return Returns a table of size (length of lstGenes) x 2, where each row
#'    contains the gene name and its pTS value (if found).
#'
#' @examples
#' # Example 1:
#' # Using the annotations from the output of the annotateCNV() function.
#' annotatedResult <- annotateCNV(chr = 1, start = 15654424, end = 15680097,
#'                                type = 'DEL', num_copies = 1,
#'                                reference = 'GRCh37')
#' genepTS <- findpTS(annotatedResult$symbol)
#'
#' # Example 2:
#' # Using a user-defined vector of strings consisting of gene names.
#' genepTS <- findpTS(c('ABHD15', 'ABLIM2', 'APOC1'))
#'
#' @references
#' Collins, R. L. et al. A cross-disorder dosage sensitivity map of the human
#' genome. \emph{Cell} 185, 3041-3055.e25 (2022). \href{https://www.sciencedirect.com/science/article/abs/pii/S0092867422007887#sec4.1}{Link}
#'
#' @export

findpTS <- function(lstGenes) {

  pHaplo_pTriplo_data <- NULL
  load('~/CNVds/data/pHaplo_pTriplo_data.rda')
  lstpTS <- pHaplo_pTriplo_data[c('X.gene', 'pTriplo')]

  lstGenes <- cbind(lstGenes)
  colnames(lstGenes)<-c('X.gene')
  result <- merge(lstGenes, lstpTS, by='X.gene', all.x = TRUE)

  colnames(result) <- c('gene', 'pTS')

  return(result)
}

# [END]
