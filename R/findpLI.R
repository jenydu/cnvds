#' Find pLI Scores for a List of Genes
#'
#' Given a list of genes, find the corresponding pLI scores for each gene.
#'
#' @param lstGenes A character vector of gene names.
#'
#' @return Returns a table of size (length of lstGenes) x 2, where each row
#'    contains the gene name and its pLI value (if found).
#'
#' @examples
#' # Example 1:
#' # Using the annotations from the output of the annotateCNV() function.
#' annotatedResult <- annotateCNV(chr = 1, start = 15654424, end = 15680097,
#'                                type = 'DEL', num_copies = 1,
#'                                reference = 'GRCh37')
#' genepLI <- findpLI(annotatedResult$symbol)
#'
#' # Example 2:
#' # Using a user-defined vector of strings consisting of gene names.
#' genepLI <- findpLI(c('ABHD5', 'ABLIM2', 'PRAMEF17'))
#'
#' @references
#' Karczewski, K. J. et al. The mutational constraint spectrum quantified from v
#' ariation in 141,456 humans. \emph{Nature} 581, 434–443 (2020). \href{https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7334197/}{Link}
#'
#' @export

findpLI <- function(lstGenes) {

  pLI_data <- NULL
  load('~/CNVds/data/pLI_data.rda')
  lstpLI <- pLI_data[c('gene', 'pLI')]

  ## computation ##

  lstGenes <- cbind(lstGenes)
  colnames(lstGenes)<-c('gene')
  result <- merge(lstGenes, lstpLI, by='gene', all.x = TRUE)

  colnames(result) <- c('gene', 'pLI')

  return(result)
}

# [END]
