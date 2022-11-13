#' GRCh37 Subset
#'
#' A subset of the GRCh37 reference genome dataset to only contain gene symbol,
#' chromosome, and the start & end position of each gene.
#'
#' @source The dataset is directly obtained from the 'annotables' package
#' (https://github.com/stephenturner/annotables). GRCh37 (Genome
#' Reference Consortium Human Build 37) are published by Ensembl
#' (https://useast.ensembl.org/info/about/publications.html).
#'
#' @format A matrix with columns:
#' \describe{
#'  \item{symbol}{Gene symbol, which is a short-form abbreviation for a
#'    particular gene.}
#'  \item{chr}{The chromosome which the gene is on.}
#'  \item{start}{The starting position (in bp) of the gene.}
#'  \item{end}{The ending position (in bp) of the gene.}
#' }
#' @examples
#' \dontrun{
#'  grch37
#' }
"grch37"

#' GRCh38 Subset
#'
#' A subset of the GRCh38 reference genome dataset to only contain gene symbol,
#' chromosome, and the start & end position of each gene.
#'
#' @source The dataset is directly obtained from the 'annotables' package
#' (https://github.com/stephenturner/annotables). GRCh38 (Genome
#' Reference Consortium Human Build 38) are published by Ensembl
#' (https://useast.ensembl.org/info/about/publications.html).
#'
#' @format A matrix with columns:
#' \describe{
#'  \item{symbol}{Gene symbol, which is a short-form abbreviation for a
#'    particular gene.}
#'  \item{chr}{The chromosome which the gene is on.}
#'  \item{start}{The starting position (in bp) of the gene.}
#'  \item{end}{The ending position (in bp) of the gene.}
#' }
#' @examples
#' \dontrun{
#'  grch38
#' }
"grch38"

#' Probability of Haploinsufficiency/Triplosensitivity (pHI/pTS) Reference
#'
#' A table containing 18641 autosomal genes and their corresponding probability
#' of haploinsuffciency/triplosensitivity scores.
#'
#' @source Collins, R. L. et al. A cross-disorder dosage sensitivity map of the
#' human genome. \emph{Cell} 185, 3041-3055.e25 (2022). \href{https://www.sciencedirect.com/science/article/abs/pii/S0092867422007887#sec4.1}{Link}
#'
#' @format A matrix with columns:
#' \describe{
#'  \item{X.Gene}{Gene symbol, which is a short-form abbreviation for a
#'    particular gene.}
#'  \item{pHaplo}{Probability of haploinsufficiency.}
#'  \item{pTriplo}{Probability of triplosensitivity.}
#' }
#' @examples
#' \dontrun{
#'  pHaplo_pTriplo_data
#' }
"pHaplo_pTriplo_data"

#' Probability of Loss Intolerance (pLI) Reference
#'
#' A table containing 19658 autosomal genes and their corresponding probability
#' of loss intolerance, which is the probability that a gene is intolerant to a
#' loss of function mutation.
#'
#' @source Karczewski, K. J. et al. The mutational constraint spectrum
#' quantified from variation in 141,456 humans. \emph{Nature} 581, 434–443
#' (2020). \href{https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7334197/}{Link}
#'
#' @format A matrix with columns:
#' \describe{
#'  \item{gene}{Gene symbol, which is a short-form abbreviation for a
#'    particular gene.}
#'  \item{pLI}{Probability of loss intolerance.}
#' }
#' @examples
#' \dontrun{
#'  pLI_data
#' }
"pLI_data"
# [END]
