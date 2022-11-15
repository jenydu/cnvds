#' Annotate a CNV Call
#'
#' Given a CNV call, which will include the chromosome number, start & end
#' position, type of CNV (DUP/DEL), and the number of copies, return all genes
#' that are fully contained in this region based on the GRCh37 or GRCh38
#' reference genome. This function will return a list of genes that are fully
#' encompassed by the input CNV regions, whether each gene is duplicated or
#' deleted, and the number of copies.
#'
#' @param chr An integer of the chromosome number that CNV
#'    region is in.
#' @param start An integer of the starting positon (bp) of
#'    the CNV region.
#' @param end An integer or a character string of the ending positon (bp) of
#'    the CNV region.
#' @param type A character string of either "DEL" or "DUP" indicating deletion
#'    or duplication CNV.
#' @param num_copies An integer of the number of copies of the CNV. Note that
#'    the baseline is 2 (for diploid). So num_copies = 3 would indicate 1 extra
#'    copy (duplication), and num_copies = 1 would indicate 1 less copy
#'    (deletion).
#' @param reference A character string of either "GRCh37" or "GRCh38" indicating
#'    the reference genome that the annotation will be based on.
#'
#' @return Returns a table where each row represents 1 annotated gene, and the
#'    columns contain the gene name (symbol), chromosome, start position, end
#'    position, type of CNV that it belongs to, and the number of copy changes
#'    of that CNV.
#'
#' @examples
#' # Example 1:
#' # One CNV input.
#' annotatedResult <- annotateCNV(chr = 1, start = 15654424, end = 15680097,
#'                                type = 'DEL', num_copies = 1,
#'                                reference = 'GRCh37')
#' # Example 2:
#' # Using the sample input file of 200 CNV calls, may take longer to run.
#' \dontrun{
#' sampleInputCNV <- NULL
#' load('~/CNVds/data/sampleInputCNV.rda')
#' annotated <- NULL
#' for (i in seq_along(1:nrow(sampleInputCNV))) {
#'   output <- annotateCNV(sampleInputCNV[i, 1], sampleInputCNV[i, 2],
#'                         sampleInputCNV[i, 3], sampleInputCNV[i, 4],
#'                         sampleInputCNV[i, 5], reference = 'GRCh37')
#'   annotated <- rbind(annotated, output)
#' }
#' }
#' @export

annotateCNV <- function(chr, start, end, type, num_copies, reference) {

  # check the inputs

  if(is.numeric(chr) == FALSE) {
    stop("Chromosome number must be numeric.")
  }

  if (chr > 22 || chr < 1) {
    stop("Dosage sensitivity scores are only available for human autosomal CNVs,
         therefore chr must be within 1 to 22.")
  }

  if (!(is.numeric(start) && is.numeric(end))) {
    stop("The start & end position must be numeric.")
  }

  if (start > end) {
    stop("The start position must be earlier (smaller) than the end position.")
  }

  if(is.numeric(num_copies) == FALSE) {
    stop("The number of copies must be numeric.")
  }

  if (!(type %in% c('DEL', 'DUP'))) {
    stop("CNV type must be either 'DEL' (for deletion), or 'DUP'
         (for duplication).")
  }

  if (type == 'DUP' && num_copies < 2) {
    stop("A duplication CNV must have 2 (diploid baseline) or more copies.")
  }

  if (type == 'DEL' && (num_copies > 2 || num_copies < 0)) {
    stop("A deletion CNV must have 0 to 2 (diploid baseline) copies.")
  }

  if (!(reference %in% c('GRCh37', 'GRCh38'))) {
    stop("The value for the reference genome must be 'GRCh37' or 'GRCh38'.")
  }

  if(missing(reference)){
    reference <- 'GRCh37'
    warning("Didn't specify threshold value, default to 'GRCh37'.")
  }

  ## computation ##
  grch37 <- grch38 <- NULL

  if (reference == 'GRCh37') {
    load('~/CNVds/data/grch37.rda')
    refGenome <- grch37
  } else {
    load('~/CNVds/data/grch38.rda')
    refGenome <- grch38
  }

  same_chrom <- refGenome[which(refGenome$chr == chr), ]
  match_start <- same_chrom[which(same_chrom$start >= start), ]
  match_end <- same_chrom[which(match_start$end <= end), ]

  if (type == 'DUP') {
    copyNumChange <- num_copies - 2
  } else {
    copyNumChange <- 2 - num_copies
  }

  result <- match_end
  result$type <- type
  result$copyNumChange <- copyNumChange
  colnames(result)[1] <- 'gene'
  return(result)
}

# [END]
