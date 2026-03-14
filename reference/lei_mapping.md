# Download the latest LEI mapping data

Download the latest Legal Entity Identifier (LEI) mapping data from the
Global Legal Entity Identifier Foundation (GLEIF).

## Usage

``` r
lei_mapping(type = c("isin", "bic", "mic", "oc"))
```

## Source

<https://www.gleif.org/en/lei-data/lei-mapping>

## Arguments

- type:

  (`character(1)`)  
  The type of mapping data to download. One of `"isin"`, `"bic"`,
  `"mic"`, or `"oc"`. Default is `"isin"`.

## Value

A [`data.frame()`](https://rdrr.io/r/base/data.frame.html) with the lei
and the corresponding mapping.

## Examples

``` r
if (FALSE) { # \dontrun{
lei_mapping("isin")
} # }
```
