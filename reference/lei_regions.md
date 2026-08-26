# Fetch LEI regions

Fetches the list of regions from the GLEIF API.

## Usage

``` r
lei_regions()
```

## Value

A [`data.frame()`](https://rdrr.io/r/base/data.frame.html) with columns:

- **code**: The region code

- **language**: The language of the region name

- **name**: The region name

## Examples

``` r
# \donttest{
head(lei_regions())
#> iterating ■■■■■■                            15% | ETA:  7s
#> iterating ■■■■■■■■■                         27% | ETA:  6s
#> iterating ■■■■■■■■■■■■■■■■■■■■■■            69% | ETA:  2s
#> iterating ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  100% | ETA:  0s
#>    code language                name
#> 1 AD-02       ca             Canillo
#> 2 AD-03       ca              Encamp
#> 3 AD-04       ca          La Massana
#> 4 AD-05       ca              Ordino
#> 5 AD-06       ca Sant Julià de Lòria
#> 6 AD-07       ca    Andorra la Vella
# }
```
