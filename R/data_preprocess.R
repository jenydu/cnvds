#' @import dplyr
library(dplyr)

pLI_loeuf_dat <- read.csv("data/pLI_loeuf_scores_raw.tsv", sep = '\t',
                          header = TRUE)

pLI_loeuf_dat <- select(pLI_loeuf_dat, gene, pLI, oe_lof_upper)

pLI_loeuf_dat <- pLI_loeuf_dat[order(pLI_loeuf_dat$gene, pLI_loeuf_dat$pLI),]
for (i in 1:(nrow(pLI_loeuf_dat)-47)) {
  if (pLI_loeuf_dat[i,1] == pLI_loeuf_dat[i+1,1]) {
    pLI_loeuf_dat <- pLI_loeuf_dat[-c(i+1), ]
  }
}

saveRDS(pLI_loeuf_dat, file = "data/pLI_LOEUF_data.rds")


dat <- read.csv("data/haplo_triplo_scores_raw.tsv", sep = '\t',
                          header = TRUE)
saveRDS(dat, file = "data/pHaplo_pTriplo_data.rds")
