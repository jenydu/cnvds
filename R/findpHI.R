#' Find pHI Scores for a List of Genes
#'
#' Given a list of genes, find the corresponding pHI scores for each gene.
#'
#' @param lstGenes A character vector of gene names.
#'
#' @return Returns a table of size (length of lstGenes) x 2, where each row
#'    contains the gene name and its pHI value (if found).
#'
#' @examples
#' # Example 1:
#' # Using the annotations from the output of the annotateCNV() function.
#' annotatedResult <- annotateCNV(chr = 1, start = 15654424, end = 15680097,
#'                                type = 'DEL', num_copies = 1,
#'                                reference = 'GRCh37')
#' genepHI <- findpHI(annotatedResult$symbol)
#'
#' # Example 2:
#' # Using a user-defined vector of strings consisting of gene names.
#' genepHI <- findpHI(c('ABHD15', 'ABLIM2', 'APOC1'))
#'
#' @references
#' Collins, R. L. et al. A cross-disorder dosage sensitivity map of the human
#' genome. \emph{Cell} 185, 3041-3055.e25 (2022). \href{https://www.sciencedirect.com/science/article/abs/pii/S0092867422007887#sec4.1}{Link}
#'
#' @export

findpHI <- function(lstGenes) {

  pHaplo_pTriplo_data <- NULL
  load('~/CNVds/data/pHaplo_pTriplo_data.rda')
  lstpHI <- pHaplo_pTriplo_data[c('X.gene', 'pHaplo')]

  lstGenes <- cbind(lstGenes)
  colnames(lstGenes)<-c('X.gene')
  result <- merge(lstGenes, lstpHI, by='X.gene', all.x = TRUE)

  colnames(result) <- c('gene', 'pHI')

  return(result)
}
# [END]
