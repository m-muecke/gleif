# Fetch the list of jurisdictions

Fetches the list of jurisdictions (countries and their subdivisions)
recognized by the GLEIF API.

## Usage

``` r
lei_jurisdictions()
```

## Value

A [`data.frame()`](https://rdrr.io/r/base/data.frame.html) with columns:

- **code**: The jurisdiction code

- **name**: The jurisdiction name

## Examples

``` r
# \donttest{
head(lei_jurisdictions())
#> iterating ■■■■■■■■■                         26% | ETA:  3s
#> iterating ■■■■■■■■■■■■■■■■■■■■■■■■■■■■      89% | ETA:  0s
#> iterating ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  100% | ETA:  0s
#>    code    name
#> 1    AD Andorra
#> 2 AD-02    <NA>
#> 3 AD-03    <NA>
#> 4 AD-04    <NA>
#> 5 AD-05    <NA>
#> 6 AD-06    <NA>
# }
```
