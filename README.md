
# reTCR

TCR Repertoire Analysis in R

> [!WARNING]
> The package work is in progress.

## Installation

Install the development version:

``` r
devtools::install_github("Mangul-Lab-USC/reTCR")
```

## Example

``` r
library(reTCR)

proj <- reTCR::get_study(id="PRJNA473147", attribute_col="cmv_status")

# view data
print(proj@data)
```

## 1. Basic Analysis

``` r
# summary data
print(proj@basic@summary_data)

# reads count
print(proj@basic@reads_count)

# clonotype count
print(proj@basic@clonotype_count)

# mean frequency
print(proj@basic@mean_freq)

# geometric mean of clonotype frequency
print(proj@basic@geomean_freq)

# mean length of CDR3 nucleotide sequence
print(proj@basic@mean_cdr3nt_len)

# convergence
print(proj@basic@convergence)

# spectratype
print(proj@basic@spectratype)
```

### 1.2 Statistical Analysis

D'Agostino normality test

``` r
library(fBasics)

# using clonotype count
dagoTest(proj@basic@summary_data$clonotype_count)
```
Shapiro-Wilk normality test

``` r
library(stats)

# using clonotype count
shapiro.test(proj@basic@summary_data$clonotype_count)
```
