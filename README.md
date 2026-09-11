# r-messy-data-import

Data import & cleaning practice set in **R**, written in the style of a university *Data Preparation* lab session (step-by-step exercises with hints, plus a fully commented solution file).

Built for a GitHub portfolio to demonstrate **hands-on data-wrangling skills** for data analyst / business analytics interviews.

## What this project shows

- Importing tabular files with `readr`: `read_tsv()` / `read_delim()`, `skip`, `col_names`, compact `col_types`
- Splitting one merged column into code + description with `tidyr::separate()`
- Detecting and skipping **metadata lines** inside a data file
- Cleaning fields with regular expressions: trimming, quote removal, format detection
- Converting messy currency strings (`$1,234,567`, `USD 200 000`, `(45,000)`) to numeric **without losing data**
- Standardising categorical values (`S.Korea` -> `South Korea`, `UNDP` / `UN Development Programme` -> `UNDP`)
- Frequency tables and quality-flagging

## Files

| File | Purpose |
|------|---------|
| `exercises.R` | The exercises with hints - try them before peeking |
| `solutions.R` | Fully commented solutions with expected outputs printed |
| `data/medicare_hospital_costs.tsv` | Hospital charge data with a merged DRG column + metadata title line |
| `data/employees_broken2.txt` | Semicolon-separated payroll export with metadata lines and messy fields |
| `data/foreign_aid.tsv` | Country funding records with messy currency strings |

## How to run

```r
install.packages(c("readr", "tidyr", "dplyr", "stringr"))   # once
source("solutions.R")                                        # run the whole file
```

Requires **R >= 4.0** and the tidyverse packages above. The data files are synthetic and self-contained.

## Exercises at a glance

1. **Exercise 2.1 - Hospital cost data**: import with `skip = 2` and explicit `col_types`; split the merged `DRG` column with `separate(sep = 4)`; `str_trim()` the code; strip the `- ` prefix; answer business questions (unique DRGs, highest-charge hospital).
2. **Exercise 2.2 - Broken employee file**: inspect raw lines to separate metadata from data; import with `read_delim()`; validate `id` with `^[0-9]{3}$`; remove quotes; parse two date formats; map `F`/`Female`; convert salary and flag `0` as a quality issue.
3. **Exercise 2.3 - Foreign aid**: clean country variants with `case_when()` + `grepl()`; standardise agencies and count unique values; transform currency strings to numeric handling parentheses as negatives, with only deliberate NAs; build a frequency table.

## Learning outcomes (interview talking points)

- `read_tsv` / `read_delim` parameter control (`skip`, `col_names`, `col_types`) and why `col_types` matters for leading zeros
- The **profile first, then clean** workflow: inspect raw lines before importing
- Regex-powered cleaning without `NA` loss, and knowing when an `NA` is deliberate
- `separate()`, `str_trim()`, `str_remove()`, `case_when()` as the core tidyverse cleaning toolkit
