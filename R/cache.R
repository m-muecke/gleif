#' Get or manage the gleif API cache
#'
#' `gleif_cache_dir()` returns the path where cached API responses are stored.
#' `gleif_cache_delete()` clears all cached responses.
#'
#' @details
#' The cache is only used when enabled with `options(gleif.cache = TRUE)`.
#' Cached responses are stored for 1 day by default, but this can be customized with
#' `options(gleif.cache_max_age = seconds)`.
#'
#' @name cache
#' @examples
#' \dontrun{
#' # enable caching
#' options(gleif.cache = TRUE)
#'
#' # view cache location
#' gleif_cache_dir()
#'
#' # clear the cache
#' gleif_cache_delete()
#' }
NULL

#' @rdname cache
#' @export
gleif_cache_dir <- function() {
  file.path(tools::R_user_dir("gleif", "cache"), "httr2")
}

#' @rdname cache
#' @export
gleif_cache_delete <- function() {
  cache_dir <- gleif_cache_dir()
  if (dir.exists(cache_dir)) {
    unlink(dir(cache_dir, full.names = TRUE))
  }
}

req_gleif_cache <- function(req) {
  if (isTRUE(getOption("gleif.cache", FALSE))) {
    req <- req_cache(
      req,
      path = gleif_cache_dir(),
      max_age = getOption("gleif.cache_max_age", 86400L)
    )
  }
  req
}
