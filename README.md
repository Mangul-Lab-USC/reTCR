
# TCR Repertoire Analysis in R

<img width="346" alt="reTCR_logo" src="https://github.com/EllaSchwab/reTCR/assets/118077332/2e96e990-14ad-4f52-97ff-1b0af108dc57">

This package provides a streamlined resource for uniformly processed publicly available TCR-seq data from SRA with attention to known library preparation method and normalization by read number. The goal of reTCR is to provide users with a wealth of easy to access, end-to-end, uniformly processed data for exploratory analysis. 

The raw sequencing data were processed with MiXCR using a specifc library preset for each study and further downsampled by read number allowing for comparison between samples. Normalization is crucial for separating biological signal from technical noise. Next, output from MiXCR is reformatted input into [pyTCR](https://github.com/Mangul-Lab-USC/pyTCR) for downstream analysis. Users can browse attributes such as study metadata, clonotype count per sample, and several diveristy metrics. 

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
