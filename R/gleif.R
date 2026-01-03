#' Download the latest LEI mapping data
#'
#' Download the latest Legal Entity Identifier (LEI) mapping data from the
#' Global Legal Entity Identifier Foundation (GLEIF).
#'
#' @param type (`character(1)`)\cr
#'   The type of mapping data to download.
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
#' @param id (`NULL` | `character(1)`)\cr
#'   The Legal Entity Identifier (LEI) to fetch.
#' @param simplify (`logical(1)`)\cr
#'   Should the output be simplified? Default `TRUE`.
#' @param page_size (`integer(1)`)\cr
#'   The number of records to fetch. Only relevant when `id` is `NULL`. Default `200L`.
#' @param page_number (`integer(1)`)\cr
#'   The page number to fetch. Only relevant when `id` is `NULL`. Default `200L`.
#' @returns When `simplify = TRUE`, a long-format `data.frame()` with columns:
#'   \describe{
#'     \item{lei}{The Legal Entity Identifier}
#'     \item{name}{The attribute name}
#'     \item{value}{The attribute value}
#'   }
#'   When `simplify = FALSE`, a named `list()` containing the raw API response.
#' @export
#' @examples
#' \donttest{
#' # get simplified long-format `data.frame()`
#' records <- lei_records("529900W18LQJJN6SJ336")
#'
#' # get raw API response as named `list()`
#' records_raw <- lei_records("529900W18LQJJN6SJ336", simplify = FALSE)
#'
#' # fetch available records
#' records <- lei_records()
#' }
lei_records <- function(id = NULL, simplify = TRUE, page_size = 200L, page_number = 1L) {
  stopifnot(
    is_string(id, null_ok = TRUE),
    is_flag(simplify),
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
    tab <- simplify_records(res$data$attributes)
  } else {
    val <- lapply(res$data, \(x) simplify_records(x$attributes))
    tab <- do.call(rbind, val)
  }
  tab$name <- sub("\\.X$", "", tab$name)
  tab$name <- gsub(".", "_", tab$name, fixed = TRUE)
  tab$name <- convert_camel_case(tab$name)
  tab
}

simplify_records <- function(x) {
  x <- unlist(x)
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
    req_error(body = lei_error_body) |>
    req_perform() |>
    resp_body_json()
}

fetch_lei_iter <- function(path, ...) {
  params <- list(...)
  req <- request("https://api.gleif.org/api/v1") |>
    req_url_path_append(path) |>
    req_url_query(!!!params) |>
    req_headers(Accept = "application/json") |>
    req_error(body = lei_error_body)

  resps <- httr2::req_perform_iterative(
    req,
    next_req = httr2::iterate_with_offset(
      "page[number]",
      resp_pages = \(resp) resp_body_json(resp)$meta$pagination$lastPage
    ),
    max_reqs = 10L
  )

  browser()

  data <- resps |>
    httr2::resps_data(function(resp) {
      data <- resp_body_json(resp)
    })
}

lei_error_body <- function(resp) {
  content_type <- resp_content_type(resp)
  if (content_type %in% c("application/json", "application/vnd.api+json")) {
    json <- resp_body_json(resp)
    vapply(json$errors, \(x) x$title, "")
  }
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
  td <- tempfile()
  dir.create(td)
  on.exit(unlink(td, recursive = TRUE), add = TRUE)
  tf <- file.path(td, "tempfile.zip")
  utils::download.file(url, destfile = tf, quiet = TRUE, mode = "wb")
  file <- utils::unzip(tf, exdir = td)
  mapping <- utils::read.csv(file)
  setNames(mapping, tolower(names(mapping)))
}

convert_camel_case <- function(x) {
  tolower(gsub("((?<=[a-z0-9])[A-Z]|(?!^)[A-Z](?=[a-z]))", "_\\1", x, perl = TRUE))
}
