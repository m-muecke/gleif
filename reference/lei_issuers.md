# Fetch LEI issuers

Fetches the list of LEI issuers (Local Operating Units) from the GLEIF
API.

## Usage

``` r
lei_issuers()
```

## Value

A [`data.frame()`](https://rdrr.io/r/base/data.frame.html) with columns:

- **lei**: The Legal Entity Identifier of the issuer

- **name**: The issuer name

- **marketing_name**: The marketing name

- **website**: The issuer website

- **accreditation_date**: The accreditation date

## Examples

``` r
if (FALSE) { # \dontrun{
lei_issuers()
} # }
```
