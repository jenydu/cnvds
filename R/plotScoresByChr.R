#' Plot Dosage Sensitivity Scores of the Input Genes Grouped by Chromosomes
#'
#' Given a list of genes and their corresponding dosage sensitivity scores (pLI/pHI/pTS), plot
#' the distribution of the scores and label genes that are especially
#' dosage-sensitive (i.e. above a certain user-defined threshold).
#'
#' Probability of loss intolerance (pLI) is the probability that a gene is intolerant to a loss of function mutation.
#' Probability of haploinsufficiency (pHI) is the probability that a gene is sensitive to copy number loss.
#' Probability of triplosensitivity (pTS) is the probability that the gene is sensitive to copy number gain.
#'
#' @param genes A table consisting of the following columns, in order:
#'    chromosome, gene symbol, score.
#' @param DStype A character string of the type of DS scores.
#' @param thresh A floating point number between 0 and 1 that serves as the
#'    threshold (default is 0.80). Any genes with scores above the threshold
#'    will be labeled.
#'
#' @return Returns a combined scatter plot (one for each chromosome) of the
#'    distribution of the gene scores.
#'
#' @examples
#' # Example 1:
#' # Using the sample input file of 200 CNV calls, may take longer to run.
#'
#' inputPath <- system.file("extdata", "sampleInputCNV.csv", package = "CNVds")
#' # Read data
#' sampleInputCNV <- read.csv(file = inputPath, header = TRUE)
#'
#' annotated <- NULL
#' for (i in seq_along(1:nrow(sampleInputCNV))) {
#'   output <- annotateCNV(sampleInputCNV[i, 1], sampleInputCNV[i, 2],
#'                         sampleInputCNV[i, 3], sampleInputCNV[i, 4],
#'                         sampleInputCNV[i, 5], reference = 'GRCh37')
#'   annotated <- rbind(annotated, output)
#' }
#'
#' pHIscores <- findpHI(annotated$gene)
#' annotated <- merge(annotated, pHIscores, by='gene')
#' plotScoresByChr(annotated[c('chr', 'gene', 'pHI')], 'pHI', 0.8)
#'
#'
#' # Example 2:
#' # Using a small dataset of 4 random data (not real genes & scores).
#' annotated <- data.frame(c(1, 4, 6, 7),
#'                         c('geneA', 'geneB', 'geneC', 'geneD'),
#'                         c(0.7, 0.99, 0.2, 0.5))
#' plotScoresByChr(annotated, 'pHI', 0.8)
#'
#' @export
#' @import ggplot2
#' @import tidyr
#' @import stats

plotScoresByChr <- function(genes, DStype, thresh) {
  if(ncol(genes) != 3) {
    stop("Input must have 3 columns in the following order: chromosome,
         gene symbol, dosage sensitivity score.")
  }

  if(missing(thresh)){
    thresh <- 0.80
    warning("Didn't specify threshold value, default to 0.80.")
  }

  colnames(genes) <- c('chr', 'gene', 'score')
  genes <- tidyr::drop_na(genes)
  title <- paste0(DStype, " Scores Distribution")

  chr <- NULL
  gene <- NULL
  score <- NULL
  plot <- ggplot2::ggplot(genes, label = gene) +
    geom_point(aes(x = chr, y = score, colour = score > thresh)) + theme_bw() +
    xlab("Chromosome") + ylab("Score") + ggtitle(title) +
    scale_colour_manual(values = setNames(c('red', 'gray'),c(T, F))) +
    scale_x_discrete(limits = factor(c(1:22)), expand = c(0, 1.5)) +
    geom_text(aes(x = chr, y = score,
                  label = ifelse(score > thresh, as.character(gene), '')),
                  hjust = 0, vjust = 0, size = 3)

  return(plot)
}
# [END]

