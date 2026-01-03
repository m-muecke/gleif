# Fetch LEI records

Fetch LEI records

## Usage

``` r
lei_records(id = NULL, simplify = TRUE, page_size = 200L, page_number = 1L)
```

## Arguments

- id:

  (`character(1)`)  
  The Legal Entity Identifier (LEI) to fetch.

- simplify:

  (`logical(1)`)  
  Should the output be simplified? Default `TRUE`.

- page_size:

  (`integer(1)`)  
  The number of records to fetch. Only relevant when `id` is `NULL`.
  Default `200L`.

- page_number:

  (`integer(1)`)  
  The page number to fetch. Only relevant when `id` is `NULL`. Default
  `200L`.

## Value

When `simplify = TRUE`, a long-format
[`data.frame()`](https://rdrr.io/r/base/data.frame.html) with columns:

- lei:

  The Legal Entity Identifier

- name:

  The attribute name

- value:

  The attribute value

When `simplify = FALSE`, a named
[`list()`](https://rdrr.io/r/base/list.html) containing the raw API
response.

## Examples

``` r
# \donttest{
# get simplified long-format `data.frame()`
records <- lei_records("529900W18LQJJN6SJ336")

# get raw API response as named `list()`
records_raw <- lei_records("529900W18LQJJN6SJ336", simplify = FALSE)

# fetch multiple records
records <- lei_records()
# }
```
