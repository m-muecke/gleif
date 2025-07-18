
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

Currently the download of the lei mapping data adn the retrieval of
records by LEI is supported:

``` r
library(gleif)

# fetch the latest LEI mapping data (single file with all mappings)
mapping <- lei_mapping("isin")
head(mapping)
#>                    lei         isin
#> 1 001GPB6A9XPE8XJICC14 US3158052262
#> 2 00EHHQ2ZHDCFXJCPCL46 US92204Q1031
#> 3 00KLB2PFTM3060S2N216 US4138382027
#> 4 00KLB2PFTM3060S2N216 US4138385749
#> 5 01ERPZV3DOLNXY2MLB90 US531554CN13
#> 6 01ERPZV3DOLNXY2MLB90 US531554CP60

# fetch LEI records by a given LEI identifier
records <- lei_records("001GPB6A9XPE8XJICC14")
str(records)
#> 'data.frame':    37 obs. of  3 variables:
#>  $ lei  : chr  "001GPB6A9XPE8XJICC14" "001GPB6A9XPE8XJICC14" "001GPB6A9XPE8XJ"..
#>  $ name : chr  "entity_legal_name_name" "entity_legal_name_language" "entity_"..
#>  $ value: chr  "Fidelity Advisor Leveraged Company Stock Fund" "en" "FIDELITY"..
```

## Related work

- [gleifr](https://github.com/Financial-Times/gleifr) - R package to
  support analysis of GLEIF data
