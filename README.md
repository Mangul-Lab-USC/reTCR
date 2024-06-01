
# reTCR

<!-- badges: start -->
<!-- badges: end -->

TCR Repertoire Analysis in R

## Installation

You can install the development version of reTCR like so:

``` r
devtools::install_github("Mangul-Lab-USC/reTCR")
```

## Example

``` r
library(reTCR)

proj <- reTCR::get_study(id = "PRJNA473147")

# view data
proj@data

## 1. Basic Analysis

# summary data
proj@basic@summary_data

# reads count
proj@basic@reads_count

# clonotype count
proj@basic@clonotype_count

# mean frequency
proj@basic@mean_freq

# geometric mean of clonotype frequency
proj@basic@geomean_freq

# mean length of CDR3 nucleotide sequence
proj@basic@mean_cdr3nt_len

# convergence
proj@basic@convergence

# spectratype
proj@basic@spectratype
```

