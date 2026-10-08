# Run from the repository root: Rscript --vanilla tests/smoke.R
options(warn = 2)
suppressPackageStartupMessages({
  library(readr); library(tidyr); library(dplyr); library(stringr)
})
source("solutions.R")
stopifnot(nrow(inpatient) == 7L, nrow(employees) == 7L, nrow(aid) == 15L,
          nrow(problems(inpatient)) == 0L, nrow(problems(employees)) == 0L,
          nrow(problems(aid)) == 0L,
          inpatient$ZIP[2] == "02215", employees$id[1] == "001",
          n_distinct(inpatient_separate$DRGcode) == 3L,
          !any(grepl("^- ", inpatient_separate$DRGdescription)),
          inpatient$Name[which.max(inpatient$AverageCharges)] == "MEMORIAL SLOAN CLINIC",
          !anyNA(employees$birthdate_clean),
          employees$birthdate_clean[2] == as.Date("1856-07-14"),
          sum(employees$salary_clean == 0) == 1L, agency == 8L,
          freq["South Korea"] == 4L, freq["North Korea"] == 3L,
          aid$amount_num[7] == -45000, aid$amount_num[12] == -250000,
          sum(is.na(aid$amount_num)) == 1L,
          aid$Country[is.na(aid$amount_num)] == "Kenya")
cat("Messy data import checks passed.\n")
