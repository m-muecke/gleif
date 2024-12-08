
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gleif

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/m-muecke/gleif/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/m-muecke/gleif/actions/workflows/R-CMD-check.yaml)
[![CRAN
status](https://www.r-pkg.org/badges/version/gleif)](https://CRAN.R-project.org/package=gleif)
<!-- badges: end -->

gleif is a minimal R client for the [gleif](https://www.gleif.org) API.
A major challenge when dealing with financial data is the mapping of
entities across different data sources. Especially when dealing with
legal entities, the Legal Entity Identifier (LEI) can be used to
uniquely identify entities.

## Installation

You can install the development version of gleif from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("m-muecke/gleif")
```

## Usage

Currently only the download of the lei mapping data is supported.

``` r
library(gleif)

mapping <- lei_mapping("isin")
str(mapping)
#> 'data.frame':    7481018 obs. of  2 variables:
#>  $ lei : chr  "001GPB6A9XPE8XJICC14" "00EHHQ2ZHDCFXJCPCL46" "00KLB2PFTM3060S2"..
#>  $ isin: chr  "US3158052262" "US92204Q1031" "US4138382027" "US4138385749" ...
```

## Related work

- [gleifr](https://github.com/Financial-Times/gleifr) - R package to
  support analysis of GLEIF data
