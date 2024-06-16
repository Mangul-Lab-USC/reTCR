
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

proj <- reTCR::get_study(id="PRJNA473147", attr_col="cmv_status")

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

## 2. Diversity Analysis

``` r
# shannon index values
print(proj@diversity@shannon)

# simpson index values
print(proj@diversity@simpson)

# D50 index
print(proj@diversity@d50)

# Chao1 estimate and standard deviation 
print(proj@diversity@chao1)

# Gini coefficient
print(proj@diversity@gini_coeff)
```

## 3. Clonality Analysis

``` r
# most frequent clonotypes
print(proj@clonality@most_clonotype)

# least frequent clonotypes
print(proj@clonality@least_clonotype)

# 1-Pielou index
print(proj@clonality@pielou)

# clonal proportion
print(proj@clonality@clonal_prop)

# relative abundance (in all clonotypes)
print(proj@clonality@abundance)

# relative abundance (in top 100 clonotypes)
print(proj@clonality@abundance_top)

# relative abundance (in rare clonotypes)
print(proj@clonality@abundance_rare)
```