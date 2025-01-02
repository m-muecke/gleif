
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
head(mapping)
#>                    lei         isin
#> 1 001GPB6A9XPE8XJICC14 US3158052262
#> 2 00EHHQ2ZHDCFXJCPCL46 US92204Q1031
#> 3 00KLB2PFTM3060S2N216 US4138382027
#> 4 00KLB2PFTM3060S2N216 US4138385749
#> 5 01ERPZV3DOLNXY2MLB90 US531554AA10
#> 6 01ERPZV3DOLNXY2MLB90 US531554AB92

records <- lei_records("001GPB6A9XPE8XJICC14", simplify = TRUE)
head(records)
#>                    lei                          name
#> 1 001GPB6A9XPE8XJICC14        entity_legal_name_name
#> 2 001GPB6A9XPE8XJICC14    entity_legal_name_language
#> 3 001GPB6A9XPE8XJICC14       entity_other_names_name
#> 4 001GPB6A9XPE8XJICC14   entity_other_names_language
#> 5 001GPB6A9XPE8XJICC14       entity_other_names_type
#> 6 001GPB6A9XPE8XJICC14 entity_legal_address_language
#>                                                                       value
#> 1                             Fidelity Advisor Leveraged Company Stock Fund
#> 2                                                                        en
#> 3 FIDELITY ADVISOR SERIES I - Fidelity Advisor Leveraged Company Stock Fund
#> 4                                                                        en
#> 5                                                       PREVIOUS_LEGAL_NAME
#> 6                                                                        en
```

## Related work

- [gleifr](https://github.com/Financial-Times/gleifr) - R package to
  support analysis of GLEIF data
