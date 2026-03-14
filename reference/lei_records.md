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
if (FALSE) { # \dontrun{
# get simplified long-format data.frame
lei_records("529900W18LQJJN6SJ336")

# get raw API response as named list
lei_records("529900W18LQJJN6SJ336", simplify = FALSE)

# search by legal name
lei_records(legal_name = "Deutsche Bank")
} # }
```
