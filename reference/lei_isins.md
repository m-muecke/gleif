# Fetch ISINs for a LEI

Fetches the ISINs associated with a given LEI.

## Usage

``` r
lei_isins(id)
```

## Arguments

- id:

  (`character(1)`)  
  The Legal Entity Identifier (LEI) to fetch ISINs for.

## Value

A [`data.frame()`](https://rdrr.io/r/base/data.frame.html) with columns:

- **lei**: The Legal Entity Identifier

- **isin**: The ISIN

## Examples

``` r
if (FALSE) { # \dontrun{
lei_isins("529900W18LQJJN6SJ336")
} # }
```
