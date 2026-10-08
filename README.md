# r-messy-data-import

A practice set for importing and cleaning awkward tabular files in R, laid out
as a lab session: exercises with hints, then a fully commented solution file
that prints the expected output at every step.

The data files are synthetic and deliberately unpleasant — the point is to work
with the kinds of files that come out of real reporting systems, not tidy CSVs.

## Files

| File | Purpose |
|------|---------|
| `exercises.R` | The exercises with hints |
| `solutions.R` | Commented solutions with expected outputs |
| `data/medicare_hospital_costs.tsv` | Hospital charges, merged DRG column, metadata title line |
| `data/employees_broken2.txt` | Semicolon-separated payroll export, metadata lines, messy fields |
| `data/foreign_aid.tsv` | Country funding records with currency stored as text |

## Running it

```r
install.packages(c("readr", "tidyr", "dplyr", "stringr"))   # once
source("solutions.R")
```

R 4.0 or newer with the tidyverse packages above.

## Contents

1. **Exercise 2.1 — Hospital cost data.** Import with `skip = 2` and explicit
   `col_types`; split the merged `DRG` column with `separate(sep = 4)`; trim the
   code and drop the `- ` prefix; then answer two questions (how many distinct
   DRGs, which hospital charges the most).
2. **Exercise 2.2 — Broken employee file.** Read the raw lines first to find
   where the data actually starts; import with `read_delim()`; validate `id`
   against `^[0-9]{3}$`; strip quotes; parse two different date formats; map
   `F` / `Female` onto one label; convert salary and flag `0` as a quality
   issue rather than silently treating it as a real value.
3. **Exercise 2.3 — Foreign aid.** Clean country name variants with
   `case_when()` and `grepl()`; standardise agency names and count the distinct
   values; convert currency strings to numeric, treating parentheses as
   negatives and leaving only deliberate `NA`s; build a frequency table.

## Things the exercises are designed to teach

- `read_tsv()` / `read_delim()` parameter control — `skip`, `col_names`,
  `col_types` — and why `col_types` matters when a code has leading zeros.
- Read the raw lines before importing; the metadata block is easier to spot
  there than in a parsed data frame.
- Regex cleaning that keeps `NA` where `NA` is meaningful instead of collapsing
  it into an empty string.
- `separate()`, `str_trim()`, `str_remove()` and `case_when()` cover most of
  what messy real-world files need.

## Validation

Run from the repository root:

```bash
Rscript --vanilla tests/smoke.R
```

GitHub Actions runs the same checks on every pull request. The exercise file
retains its practice tasks; automated checks run the completed solutions.
To display each solution step interactively, use `source("solutions.R", echo = TRUE)`.

## License

MIT — see [LICENSE](LICENSE).
