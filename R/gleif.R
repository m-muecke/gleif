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
#' @param legal_name (`NULL` | `character(1)`)\cr
#'   Filter by legal name. Only relevant when `id` is `NULL`.
#' @param jurisdiction (`NULL` | `character(1)`)\cr
#'   Filter by jurisdiction. Only relevant when `id` is `NULL`.
#' @param status (`NULL` | `character(1)`)\cr
#'   Filter by entity status. Only relevant when `id` is `NULL`.
#' @param fulltext (`NULL` | `character(1)`)\cr
#'   Full-text search query. Only relevant when `id` is `NULL`.
#' @param page_size (`NULL` | `integer(1)`)\cr
#'   The number of records per page. Only relevant when `id` is `NULL`. Default `200L`.
#' @param page_number (`NULL` | `integer(1)`)\cr
#'   The page number to fetch. Only relevant when `id` is `NULL`. When `NULL` (the default), all
#'   pages are fetched automatically.
#' @param simplify (`logical(1)`)\cr
#'   Should the output be simplified? Default `TRUE`.
#' @returns When `simplify = TRUE`, a long-format `data.frame()` with columns:
#' - **lei**: The Legal Entity Identifier
#' - **name**: The attribute name
#' - **value**: The attribute value
#'
#' When `simplify = FALSE`, a named `list()` containing the raw API response.
#' @export
#' @examples
#' \donttest{
#' # get simplified long-format data.frame
#' records <- lei_records("529900W18LQJJN6SJ336")
#'
#' # get raw API response as named list
#' records_raw <- lei_records("529900W18LQJJN6SJ336", simplify = FALSE)
#'
#' # fetch available records
#' records <- lei_records()
#'
#' # search by legal name
#' records <- lei_records(legal_name = "Deutsche Bank")
#' }
lei_records <- function(
  id = NULL,
  legal_name = NULL,
  jurisdiction = NULL,
  status = NULL,
  fulltext = NULL,
  page_size = 200L,
  page_number = NULL,
  simplify = TRUE
) {
  stopifnot(
    is_string(id, null_ok = TRUE),
    is_string(legal_name, null_ok = TRUE),
    is_string(jurisdiction, null_ok = TRUE),
    is_string(status, null_ok = TRUE),
    is_string(fulltext, null_ok = TRUE),
    is_count(page_size),
    is_count(page_number, null_ok = TRUE),
    is_flag(simplify)
  )
  has_id <- !is.null(id)
  has_filter <- !is.null(legal_name) ||
    !is.null(jurisdiction) ||
    !is.null(status) ||
    !is.null(fulltext)
  if (has_id && has_filter) {
    stop("Cannot combine `id` with filter parameters.", call. = FALSE)
  }
  path <- "lei-records"
  if (has_id) {
    path <- paste(path, id, sep = "/")
    res <- fetch_lei(path)
  } else if (is.null(page_number)) {
    data <- fetch_lei_iter(
      path,
      `page[size]` = page_size,
      `filter[entity.legalName]` = legal_name,
      `filter[entity.jurisdiction]` = jurisdiction,
      `filter[entity.status]` = status,
      `filter[fulltext]` = fulltext
    )
    if (!simplify) {
      return(data)
    }
    val <- lapply(data, \(x) simplify_records(x$attributes))
    tab <- do.call(rbind, val)
    return(clean_names(tab))
  } else {
    res <- fetch_lei(
      path,
      `page[size]` = page_size,
      `page[number]` = page_number,
      `filter[entity.legalName]` = legal_name,
      `filter[entity.jurisdiction]` = jurisdiction,
      `filter[entity.status]` = status,
      `filter[fulltext]` = fulltext
    )
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
  clean_names(tab)
}

#' Fetch LEI regions
#'
#' Fetches the list of regions from the GLEIF API.
#'
#' @returns A `data.frame()` with columns:
#' - **code**: The region code
#' - **language**: The language of the region name
#' - **name**: The region name
#' @export
#' @examples
#' \donttest{
#' regions <- lei_regions()
#' }
lei_regions <- function() {
  resp <- fetch_lei("regions", `page[size]` = 100L)
  data <- resp$data
  rows <- lapply(data, function(x) {
    code <- x$attributes$code
    nms <- x$attributes$names
    data.frame(
      code = code,
      language = vapply(nms, \(y) y$language, NA_character_),
      name = vapply(nms, \(y) y$name, NA_character_),
      check.names = FALSE
    )
  })
  do.call(rbind, rows)
}

#' Fetch LEI parent records
#'
#' Fetches the direct or ultimate parent record of a given LEI.
#'
#' @param id (`character(1)`)\cr
#'   The Legal Entity Identifier (LEI) to fetch the parent for.
#' @param type (`character(1)`)\cr
#'   The type of parent to fetch. One of `"direct"` or `"ultimate"`. Default is `"direct"`.
#' @param simplify (`logical(1)`)\cr
#'   Should the output be simplified? Default `TRUE`.
#' @returns When `simplify = TRUE`, a long-format `data.frame()` with columns:
#' - **lei**: The Legal Entity Identifier
#' - **name**: The attribute name
#' - **value**: The attribute value
#'
#' When `simplify = FALSE`, a named `list()` containing the raw API response.
#' @export
#' @examples
#' \donttest{
#' # get direct parent
#' parent <- lei_parents("529900W18LQJJN6SJ336")
#'
#' # get ultimate parent
#' parent <- lei_parents("529900W18LQJJN6SJ336", type = "ultimate")
#' }
lei_parents <- function(id, type = c("direct", "ultimate"), simplify = TRUE) {
  type <- match.arg(type)
  stopifnot(is_string(id), is_flag(simplify))
  path <- paste("lei-records", id, paste0(type, "-parent"), sep = "/")
  res <- fetch_lei(path)
  if (!simplify) {
    return(res)
  }
  tab <- simplify_records(res$data$attributes)
  clean_names(tab)
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

clean_names <- function(tab) {
  tab$name <- sub("\\.X$", "", tab$name)
  tab$name <- gsub(".", "_", tab$name, fixed = TRUE)
  tab$name <- convert_camel_case(tab$name)
  tab
}

fetch_lei_iter <- function(path, ...) {
  params <- list(...)
  req <- request("https://api.gleif.org/api/v1") |>
    req_url_path_append(path) |>
    req_url_query(!!!params) |>
    req_headers(Accept = "application/json") |>
    req_error(body = lei_error_body)

  resps <- req_perform_iterative(
    req,
    next_req = iterate_with_offset(
      "page[number]",
      resp_pages = \(resp) resp_body_json(resp)$meta$pagination$lastPage
    )
  )

  resps_data(resps, \(resp) resp_body_json(resp)$data)
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
