# Fetch LEI records

Fetch LEI records

## Usage

``` r
lei_records(
  id = NULL,
  legal_name = NULL,
  jurisdiction = NULL,
  status = NULL,
  fulltext = NULL,
  page_size = 200L,
  page_number = NULL,
  simplify = TRUE
)
```

## Arguments

- id:

  (`NULL` \| `character(1)`)  
  The Legal Entity Identifier (LEI) to fetch.

- legal_name:

  (`NULL` \| `character(1)`)  
  Filter by legal name. Only relevant when `id` is `NULL`.

- jurisdiction:

  (`NULL` \| `character(1)`)  
  Filter by jurisdiction. Only relevant when `id` is `NULL`.

- status:

  (`NULL` \| `character(1)`)  
  Filter by entity status. Only relevant when `id` is `NULL`.

- fulltext:

  (`NULL` \| `character(1)`)  
  Full-text search query. Only relevant when `id` is `NULL`.

- page_size:

  (`NULL` \| `integer(1)`)  
  The number of records per page. Only relevant when `id` is `NULL`.
  Default `200L`.

- page_number:

  (`NULL` \| `integer(1)`)  
  The page number to fetch. Only relevant when `id` is `NULL`. When
  `NULL` (the default), all pages are fetched automatically.

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
# \donttest{
# get simplified long-format data.frame
records <- lei_records("529900W18LQJJN6SJ336")

# get raw API response as named list
records_raw <- lei_records("529900W18LQJJN6SJ336", simplify = FALSE)

# fetch available records
records <- lei_records()
#> iterating ■■■                                5% | ETA: 30s
#> iterating ■■■■■                             15% | ETA: 26s
#> iterating ■■■■■■■■■                         25% | ETA: 22s
#> iterating ■■■■■■■■■■■                       35% | ETA: 19s
#> iterating ■■■■■■■■■■■■■■■                   45% | ETA: 16s
#> iterating ■■■■■■■■■■■■■■■■■                 55% | ETA: 13s
#> iterating ■■■■■■■■■■■■■■■■■■■■■             65% | ETA: 10s
#> iterating ■■■■■■■■■■■■■■■■■■■■■■■           75% | ETA:  7s
#> iterating ■■■■■■■■■■■■■■■■■■■■■■■■■■■       85% | ETA:  4s
#> iterating ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■     95% | ETA:  1s
#> iterating ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  100% | ETA:  0s

# search by legal name
records <- lei_records(legal_name = "Deutsche Bank")
#> iterating ■■■                                5% | ETA: 31s
#> iterating ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  100% | ETA:  0s
# }
```
