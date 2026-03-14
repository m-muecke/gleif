# Fetch LEI parent records

Fetches the direct or ultimate parent record of a given LEI.

## Usage

``` r
lei_parents(id, type = c("direct", "ultimate"), simplify = TRUE)
```

## Arguments

- id:

  (`character(1)`)  
  The Legal Entity Identifier (LEI) to fetch the parent for.

- type:

  (`character(1)`)  
  The type of parent to fetch. One of `"direct"` or `"ultimate"`.
  Default is `"direct"`.

- simplify:

  (`logical(1)`)  
  Should the output be simplified? Default `TRUE`.

## Value

When `simplify = TRUE`, a long-format
[`data.frame()`](https://rdrr.io/r/base/data.frame.html) with columns:

- **lei**: The Legal Entity Identifier

- **name**: The attribute name

- **value**: The attribute value

When `simplify = FALSE`, a named
[`list()`](https://rdrr.io/r/base/list.html) containing the raw API
response.

## Examples

``` r
if (FALSE) { # \dontrun{
# get direct parent
lei_parents("529900W18LQJJN6SJ336")

# get ultimate parent
lei_parents("529900W18LQJJN6SJ336", type = "ultimate")
} # }
```
