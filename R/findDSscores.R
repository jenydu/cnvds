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
#' genepHI <- findpHI(annotatedResult$gene)
#'
#' # Example 2:
#' # Using a user-defined vector of strings consisting of gene names.
#' genepHI <- findpHI(c('ABHD15', 'ABLIM2', 'APOC1'))
#'
#' @references
#' Collins, R. L. et al. (2022). A cross-disorder dosage sensitivity map of the human
#' genome. \emph{Cell} 185, 3041-3055.e25. \href{https://www.sciencedirect.com/science/article/abs/pii/S0092867422007887#sec4.1}{Link}
#'
#' @export

findpHI <- function(lstGenes) {

  lstpHI <- pHaplo_pTriplo_data[c('X.gene', 'pHaplo')]

  lstGenes <- cbind(lstGenes)
  colnames(lstGenes) <- c('X.gene')
  result <- merge(lstGenes, lstpHI, by = 'X.gene', all.x = TRUE)

  colnames(result) <- c('gene', 'pHI')

  return(result)
}

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
#' genepTS <- findpTS(annotatedResult$gene)
#'
#' # Example 2:
#' # Using a user-defined vector of strings consisting of gene names.
#' genepTS <- findpTS(c('ABHD15', 'ABLIM2', 'APOC1'))
#'
#' @references
#' Collins, R. L. et al.(2022). A cross-disorder dosage sensitivity map of the human
#' genome. \emph{Cell} 185, 3041-3055.e25. \href{https://www.sciencedirect.com/science/article/abs/pii/S0092867422007887#sec4.1}{Link}
#'
#' @export

findpTS <- function(lstGenes) {

  lstpTS <- pHaplo_pTriplo_data[c('X.gene', 'pTriplo')]

  lstGenes <- cbind(lstGenes)
  colnames(lstGenes) <- c('X.gene')
  result <- merge(lstGenes, lstpTS, by = 'X.gene', all.x = TRUE)

  colnames(result) <- c('gene', 'pTS')

  return(result)
}

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
#' genepLI <- findpLI(annotatedResult$gene)
#'
#' # Example 2:
#' # Using a user-defined vector of strings consisting of gene names.
#' genepLI <- findpLI(c('ABHD5', 'ABLIM2', 'PRAMEF17'))
#'
#' @references
#' Karczewski, K. J. et al. (2020). The mutational constraint spectrum
#' quantified from variation in 141,456 humans.
#' \emph{Nature} 581, 434–443. \href{https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7334197/}{Link}
#'
#' @export

findpLI <- function(lstGenes) {

  lstpLI <- pLI_data[c('gene', 'pLI')]

  ## computation ##

  lstGenes <- cbind(lstGenes)
  colnames(lstGenes) <- c('gene')
  result <- merge(lstGenes, lstpLI, by = 'gene', all.x = TRUE)
  colnames(result) <- c('gene', 'pLI')

  return(result)
}

# [END]
