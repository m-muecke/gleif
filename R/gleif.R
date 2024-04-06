latest_url <- function(type = c("isin", "bic", "mic", "oc")) {
  type <- match.arg(type)
  # nolint start
  url <- switch(type,
    isin = "https://www.gleif.org/en/lei-data/lei-mapping/download-isin-to-lei-relationship-files",
    bic = "https://www.gleif.org/en/lei-data/lei-mapping/download-bic-to-lei-relationship-files",
    mic = "https://www.gleif.org/en/lei-data/lei-mapping/download-mic-to-lei-relationship-files",
    oc = "https://www.gleif.org/en/lei-data/lei-mapping/download-oc-to-lei-relationship-files"
  )
  # nolint end
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

#' Download the latest LEI mapping data
#'
#' @param type `character(1)` the type of mapping data to download.
#' @export
#' @references <https://www.gleif.org/en/lei-data/lei-mapping>
lei_mapping <- function(type = c("isin", "bic", "mic", "oc")) {
  url <- latest_url(type)
  mapping <- gleif_download(url)
  as_tibble(mapping)
}
