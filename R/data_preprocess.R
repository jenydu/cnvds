#' @import dplyr
library(dplyr)

pLI_loeuf_dat <- read.csv("data/pLI_loeuf_scores_raw.tsv", sep = '\t',
                          header = TRUE)

pLI_loeuf_dat <- select(pLI_loeuf_dat, gene, pLI, oe_lof_upper)
saveRDS(pLI_loeuf_dat, file = "data/pLI_LOEUF_data.rds")


dat <- read.csv("data/haplo_triplo_scores_raw.tsv", sep = '\t',
                          header = TRUE)
saveRDS(dat, file = "data/pHaplo_pTriplo_data.rds")
