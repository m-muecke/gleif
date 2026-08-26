# Fetch the list of entity legal forms

Fetches the list of entity legal forms (ELF codes) recognized by the
GLEIF API. These resolve the legal form codes that appear in
[`lei_record_by_id()`](https://m-muecke.github.io/gleifr/reference/lei_record_by_id.md)
output to human-readable names.

## Usage

``` r
lei_legal_forms()
```

## Value

A [`data.frame()`](https://rdrr.io/r/base/data.frame.html) with columns:

- **code**: The entity legal form (ELF) code

- **country**: The country the legal form applies to

- **country_code**: The country code

- **status**: The status of the legal form, e.g. `"ACTV"`

- **name**: The local name of the legal form

- **language**: The language of the name

## Examples

``` r
# \donttest{
head(lei_legal_forms())
#> iterating ■■■■■■■■■                         28% | ETA:  4s
#> iterating ■■■■■■■■■■■■■■■■■■■■■■■■■■■■      89% | ETA:  1s
#> iterating ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  100% | ETA:  0s
#>   code                  country country_code status                        name
#> 1 09K3            Faroe Islands           FO   ACTV   Samstarvsfelag við ábyrgd
#> 2 0AWU United States of America           US   ACTV                credit union
#> 3 0GY3 United States of America           US   ACTV                credit union
#> 4 0NYS                Singapore           SG   ACTV                 Partnership
#> 5 0OCP                 Viet Nam           VN   ACTV công ty trách nhiệm hữu hạn
#> 6 0SKB United States of America           US   ACTV                credit union
#>     language
#> 1    Faroese
#> 2    English
#> 3    English
#> 4    English
#> 5 Vietnamese
#> 6    English
# }
```
