
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gleif

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/m-muecke/gleif/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/m-muecke/gleif/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of gleif is to provide a simple interface to the …

## Installation

You can install the development version of gleif from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("m-muecke/gleif")
```

## Usage

Currently on the download of the lei mapping data is supported.

``` r
library(gleif)

mapping <- lei_mapping("isin")
mapping
#> # A tibble: 7,341,989 × 2
#>   lei                  isin
#>   <chr>                <chr>
#> 1 001GPB6A9XPE8XJICC14 US3158052262
#> 2 00EHHQ2ZHDCFXJCPCL46 US92204Q1031
#> 3 00KLB2PFTM3060S2N216 US4138382027
#> 4 00KLB2PFTM3060S2N216 US4138385749
#> 5 01ERPZV3DOLNXY2MLB90 US531554AA10
#> # ℹ 7,341,984 more rows
```
