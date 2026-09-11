# =============================================================================
# r-messy-data-import
# Data Preparation practice set: Importing & Cleaning Messy Data in R
# -----------------------------------------------------------------------------
# Style: step-by-step exercises with hints (a), b), c), ...).
# Solutions are in solutions.R - try the exercises first!
#
# Required packages: readr, tidyr, dplyr, stringr
#   install.packages(c("readr", "tidyr", "dplyr", "stringr"))
# =============================================================================

library(readr)
library(tidyr)
library(dplyr)
library(stringr)

# -----------------------------------------------------------------------------
# Exercise 2.1 - Hospital cost data with a broken DRG column
# (retake of the classic DRG exercise)
# -----------------------------------------------------------------------------
# File: data/medicare_hospital_costs.tsv
# It starts with ONE metadata title line, then the column header, then data.
# Because we supply col_names ourselves, we skip BOTH the title and the
# original header when importing.
# The DRG column merges the code AND the description ("460 - SPINAL FUSION ...").
#
# a) Define the column names:
#    c("DRG", "ProviderID", "Name", "Address", "City", "State", "ZIP",
#      "Region", "Discharges", "AverageCharges", "AverageTotalPayments",
#      "AverageMedicarePayments")
#    Import the file with read_tsv(), skip = 2, these names, and the compact
#    col_types string "ccccccccnnnn" (8 character columns, 4 numeric columns).
#    Store the result in inpatient.
# b) Split the DRG column into DRGcode and DRGdescription using separate()
#    with sep = 4 (the code occupies the first 4 characters).
# c) Trim the DRGcode field with str_trim() - the code came out with a
#    trailing space.
# d) Remove the "- " prefix at the beginning of DRGdescription with str_remove().
# e) Answer: how many UNIQUE DRG codes are there? Which hospital has the
#    highest AverageCharges?

# -----------------------------------------------------------------------------
# Exercise 2.2 - The broken employee file
# (retake of the employees_broken exercise)
# -----------------------------------------------------------------------------
# File: data/employees_broken2.txt - a semicolon-separated file produced by a
# payroll system. It contains metadata lines at the top and messy records.
#
# a) Read the raw file with readLines() and look at the first few lines.
#    What kind of file is it? Which lines are METADATA and which are DATA?
# b) Import the data part with read_delim() (delimiter ";"), skipping the
#    metadata, and using col_names = c("id", "name", "birthdate", "gender",
#    "salary"). Read every column as character for now.
# c) Use a regular expression to CHECK the id column: every id must be exactly
#    three digits (pattern "^[0-9]{3}$").
# d) Clean the name column: some names are surrounded by quotes. Remove the
#    quotes and squash repeated whitespace.
# e) Clean the birthdate column: it appears in TWO formats -
#    "1985-03-14" (YYYY-MM-DD) and "14/07/1856" (DD/MM/YYYY).
#    Detect the format with a regex and convert everything to a Date.
# f) Clean the gender column: "F" and "Female" both mean F, "M" means M.
# g) Clean the salary column: remove any symbols and convert to numeric.
#    Flag salary values of 0 as a data-quality issue.

# -----------------------------------------------------------------------------
# Exercise 2.3 - Foreign aid dataset
# (long exercise with a lot of small manipulations)
# -----------------------------------------------------------------------------
# File: data/foreign_aid.tsv - country-level funding records.
#
# a) Import the file with read_tsv() - it has a proper header row - and
#    inspect the result. How many rows? What types were guessed?
# b) Clean the country column: we have exactly two Koreas.
#    "S.Korea" and "Republic of Korea" should become "South Korea";
#    "N. Korea" and "DPRK" should become "North Korea".
#    Use grepl()-based conditions inside dplyr::case_when().
# c) Clean the FundingAgency column: "UN Development Programme" and "UNDP"
#    are the same agency. Standardise them. Then count how many UNIQUE
#    agencies exist and store that number in a constant called agency.
# d) Transform FundingAmount to NUMERIC without creating NAs:
#      - remove "$", "USD", commas and spaces
#      - "(45,000)" means a NEGATIVE amount (-45000)
#    Apply as.numeric() only after cleaning. Document which values (if any)
#    stay NA and why that is deliberate.
# e) Create a frequency table of the CLEANED country column (table()).
#    Verify the counts for South Korea and North Korea.
