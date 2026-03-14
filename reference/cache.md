# Get or manage the gleif API cache

`gleif_cache_dir()` returns the path where cached API responses are
stored. `gleif_cache_delete()` clears all cached responses.

## Usage

``` r
gleif_cache_dir()

gleif_cache_delete()
```

## Details

The cache is only used when enabled with `options(gleif.cache = TRUE)`.
Cached responses are stored for 1 day by default, but this can be
customized with `options(gleif.cache_max_age = seconds)`.

## Examples

``` r
if (FALSE) { # \dontrun{
# enable caching
options(gleif.cache = TRUE)

# view cache location
gleif_cache_dir()

# clear the cache
gleif_cache_delete()
} # }
```
