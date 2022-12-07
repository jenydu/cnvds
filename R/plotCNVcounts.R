#' Plot Number of CNVS Grouped by Chromosomes
#'
#' Given a list of CNV calls, plot the total number of unique duplication and
#' deletion CNV regions in each chromosome.
#'
#' @param lstCNV A table consisting of the following columns, in order:
#'    chromosome number, start position, end position,
#'    type of CNV ('DUP'/'DEL').
#'
#' @return Returns a barplot of the number of duplication and deletion CNVs
#'    grouped by chromosomes.
#'
#' @examples
#' # Example 1:
#' # A mini example of 4 random CNV regions.
#' CNVinput <- data.frame(c(1, 1, 2, 3),
#'                        c(12312, 293012, 3829103, 3281901),
#'                        c(23423, 402405, 4025002, 8531273),
#'                        c('DEL', 'DUP', 'DEL', 'DEL'))
#' plotCNVcounts(CNVinput)
#'
#' # Example 2:
#' # Using the sample input of a list of CNV calls.
#' inputPath <- system.file("extdata", "sampleInputCNV.csv", package = "CNVds")
#' # Read data
#' sampleInputCNV <- read.csv(file = inputPath, header = TRUE)
#' plotCNVcounts(sampleInputCNV[c(1:4)])
#'
#' @export
#' @import ggplot2

plotCNVcounts <- function(lstCNV) {

  if (ncol(lstCNV) != 4) {
    stop("Input must have 4 columns in the following order: chromosome number,
         start position, end position, type.")
  }

  CNVtypes <- sort(unique(lstCNV[,4]))
  if (CNVtypes[1] !=  'DEL' || (CNVtypes[2] != 'DUP')) {
    stop("CNV type must be either 'DEL' (for deletion), or 'DUP'
         (for duplication).")
  }

  colnames(lstCNV) <- c('chr', 'start', 'end', 'type')

  chr <- NULL
  type <- NULL
  plot_bar <- ggplot2::ggplot(lstCNV, aes(x = chr, fill = type)) +
    geom_bar(color = 'black', position = 'dodge') +
    xlab("Chromosome") + ylab("Count") +
    ggtitle("Number of CNV Regions in Each Chromosome") +
    scale_fill_manual("CNV Type",
                      values = c("DEL" = "deepskyblue", "DUP" = "gold")) +
    theme_bw() + scale_x_continuous(breaks = seq(1, 22, by = 1)) +
    scale_y_continuous(expand = c(0,0))

  return(plot_bar)
}
# [END]

