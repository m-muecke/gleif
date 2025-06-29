#' Download the latest LEI mapping data
#'
#' Download the latest Legal Entity Identifier (LEI) mapping data from the
#' Global Legal Entity Identifier Foundation (GLEIF).
#'
#' @param type (`character(1)`) the type of mapping data to download.
#'   One of `"isin"`, `"bic"`, `"mic"`, or `"oc"`. Default is `"isin"`.
#' @returns A `data.frame()` with the lei and the corresponding mapping.
#' @source <https://www.gleif.org/en/lei-data/lei-mapping>
#' @export
#' @examples
#' \donttest{
#' lei_mapping("isin")
#' }
lei_mapping <- function(type = c("isin", "bic", "mic", "oc")) {
  url <- latest_url(type)
  gleif_download(url)
}

#' Fetch LEI records
#'
#' @param id (`character(1)`) the Legal Entity Identifier (LEI) to fetch.
#' @param simplify (`logical(1)`) should the output be simplified?
#' @param page_size (`integer(1)`) the number of records to fetch.
#'   Only relevant when `id` is `NULL`. Default `100L`.
#' @param page_number (`integer(1)`) the page number to fetch.
#'   Only relevant when `id` is `NULL`. Default `100L`.
#' @returns The request LEI records.
#' @export
#' @examples
#' \donttest{
#' tab <- lei_records("529900W18LQJJN6SJ336", simplify = TRUE)
#' tab <- lei_records(simplify = TRUE)
#' }
lei_records <- function(id = NULL, simplify = FALSE, page_size = 100L, page_number = 1L) {
  stopifnot(
    is_string(id, null_ok = TRUE),
    is_bool(simplify),
    is_count(page_size),
    is_count(page_number)
  )
  has_id <- !is.null(id)
  path <- "lei-records"
  if (has_id) {
    path <- paste(path, id, sep = "/")
    res <- fetch_lei(path)
  } else {
    res <- fetch_lei(path, `page[size]` = page_size, `page[number]` = page_number)
  }
  if (!simplify) {
    return(res)
  }

  if (has_id) {
    x <- unlist(res$data$attributes)
    tab <- simplify_records(x)
  } else {
    res <- lapply(res$data, function(x) {
      x <- unlist(x$attributes)
      simplify_records(x)
    })
    tab <- do.call(rbind, res)
  }
  tab$name <- sub("\\.X$", "", tab$name)
  tab$name <- gsub(".", "_", tab$name, fixed = TRUE)
  tab$name <- convert_camel_case(tab$name)
  tab
}

simplify_records <- function(x) {
  lei <- x[["lei"]]
  x <- x[names(x) != "lei"]
  data.frame(
    lei = lei,
    name = names(x),
    value = unname(x),
    check.names = FALSE
  )
}

fetch_lei <- function(path, ...) {
  params <- list(...)
  request("https://api.gleif.org/api/v1") |>
    req_url_path_append(path) |>
    req_url_query(!!!params) |>
    req_headers(Accept = "application/json") |>
    req_perform() |>
    resp_body_json()
}

latest_url <- function(type = c("isin", "bic", "mic", "oc")) {
  type <- match.arg(type)
  url <- "https://www.gleif.org/en/lei-data/lei-mapping"
  endpoint <- switch(
    type,
    isin = "download-isin-to-lei-relationship-files",
    bic = "download-bic-to-lei-relationship-files",
    mic = "download-mic-to-lei-relationship-files",
    oc = "download-oc-to-lei-relationship-files"
  )
  url <- paste(url, endpoint, sep = "/")
  files <- rvest::read_html(url) |>
    rvest::html_element("table") |>
    rvest::html_elements("a") |>
    rvest::html_attr("href")
  files[[1L]]
}

gleif_download <- function(url) {
  tmp <- tempfile()
  dir.create(tmp)
  on.exit(unlink(tmp, recursive = TRUE), add = TRUE)
  tf <- file.path(tmp, "tempfile.zip")
  utils::download.file(url, destfile = tf, quiet = TRUE, mode = "wb")
  file <- utils::unzip(tf, exdir = tmp)
  mapping <- utils::read.csv(file)
  setNames(mapping, tolower(names(mapping)))
}

convert_camel_case <- function(x) {
  tolower(gsub("((?<=[a-z0-9])[A-Z]|(?!^)[A-Z](?=[a-z]))", "_\\1", x, perl = TRUE))
}
