as_tibble <- function(x) {
  if (getOption("gleif.use_tibble", TRUE) &&
        requireNamespace("tibble", quietly = TRUE)) {
    tibble::as_tibble(x)
  } else {
    x
  }
}
