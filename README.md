
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
head(proj@data)

# view basic analysis summary data
head(proj@basic@summary_data)
```

