test_that("to_snake_case works", {
  expect_identical(to_snake_case("legalName"), "legal_name")
  expect_identical(to_snake_case("entityID"), "entity_id")
  expect_identical(to_snake_case("already_snake"), "already_snake")
  expect_identical(to_snake_case("XMLParser"), "xml_parser")
})

test_that("clean_names cleans attribute names", {
  tab <- data.frame(
    lei = "123",
    name = c("entity.legalName.X", "entity.status"),
    value = c("Foo", "ACTIVE")
  )
  res <- clean_names(tab)
  expect_identical(res$name, c("entity_legal_name", "entity_status"))
})

test_that("clean_names passes NULL through", {
  expect_null(clean_names(NULL))
})

test_that("lei_record_by_id validates inputs", {
  expect_error(lei_record_by_id(id = 123))
  expect_error(lei_record_by_id(""))
  expect_error(lei_record_by_id("foo"))
  expect_error(lei_record_by_id("529900W18LQJJN6SJ33"))
  expect_error(lei_record_by_id("529900W18LQJJN6SJ33!"))
  expect_error(lei_record_by_id("529900W18LQJJN6SJ336", simplify = "yes"))
})

test_that("lei_records validates inputs", {
  expect_error(lei_records(legal_name = 123))
  expect_error(lei_records(country = 123))
  expect_error(lei_records(entity_status = 1))
  expect_error(lei_records(registration_status = 1))
  expect_error(lei_records(category = 1))
  expect_error(lei_records(isin = 1))
  expect_error(lei_records(simplify = "yes"))
  expect_error(lei_records(limit = -1))
})

test_that("lei_children validates inputs", {
  expect_error(lei_children(id = 123))
  expect_error(lei_children(id = ""))
  expect_error(lei_children(id = "529900W18LQJJN6SJ336", simplify = "yes"))
  expect_error(lei_children(id = "529900W18LQJJN6SJ336", type = "sideways"))
  expect_error(lei_children(id = "529900W18LQJJN6SJ336", limit = -1))
})

test_that("lei_isins validates inputs", {
  expect_error(lei_isins(id = 123))
  expect_error(lei_isins(id = ""))
  expect_error(lei_isins("529900W18LQJJN6SJ336", limit = -1))
})

test_that("lei_modifications validates inputs", {
  expect_error(lei_modifications(id = 123))
  expect_error(lei_modifications(id = ""))
  expect_error(lei_modifications("529900W18LQJJN6SJ336", limit = -1))
})

test_that("lei_parent validates inputs", {
  expect_error(lei_parent(id = 123))
  expect_error(lei_parent(id = ""))
  expect_error(lei_parent(id = "529900W18LQJJN6SJ336", simplify = "yes"))
})

test_that("lei_fuzzy validates inputs", {
  expect_error(lei_fuzzy(q = 123))
  expect_error(lei_fuzzy(q = "foo", field = "unsupported"))
})

test_that("lei_autocomplete validates inputs", {
  expect_error(lei_autocomplete(q = 123))
  expect_error(lei_autocomplete(q = "foo", field = "unsupported"))
})

test_that("lei_autocomplete supports ownedBy searches", {
  local_mocked_bindings(
    fetch_completions = \(path, field, q) field,
    .package = "gleifr"
  )

  expect_identical(lei_autocomplete(q = "foo", field = "ownedBy"), "ownedBy")
})

test_that("lei_issuers returns expected format", {
  skip_on_cran()
  skip_on_ci()
  skip_if_offline()

  res <- lei_issuers()
  expect_s3_class(res, "data.frame")
  expect_named(res, c("lei", "name", "marketing_name", "website", "accreditation_date"))
  expect_gt(nrow(res), 0L)
})

test_that("lei_regions returns expected format", {
  skip_on_cran()
  skip_on_ci()
  skip_if_offline()

  res <- lei_regions()
  expect_s3_class(res, "data.frame")
  expect_named(res, c("code", "language", "name"))
  expect_gt(nrow(res), 0L)
})

test_that("lei_countries returns expected format", {
  skip_on_cran()
  skip_on_ci()
  skip_if_offline()

  res <- lei_countries()
  expect_s3_class(res, "data.frame")
  expect_named(res, c("code", "name"))
  expect_gt(nrow(res), 0L)
})

test_that("paginated endpoints fetch past the first page", {
  skip_on_cran()
  skip_on_ci()
  skip_if_offline()

  expect_gt(nrow(lei_countries()), 200L)
  expect_gt(nrow(lei_registration_authorities()), 200L)
})

test_that("empty results return NULL", {
  skip_on_cran()
  skip_on_ci()
  skip_if_offline()

  no_match <- "ZZZQQQNOSUCHENTITYXYZ123"

  expect_null(lei_records(legal_name = no_match, limit = 5L))
  expect_null(lei_fuzzy(no_match, field = "entity.legalName"))
})

test_that("lei_jurisdictions returns expected format", {
  skip_on_cran()
  skip_on_ci()
  skip_if_offline()

  res <- lei_jurisdictions()
  expect_s3_class(res, "data.frame")
  expect_named(res, c("code", "name"))
  expect_gt(nrow(res), 0L)
})

test_that("lei_legal_forms returns expected format", {
  skip_on_cran()
  skip_on_ci()
  skip_if_offline()

  res <- lei_legal_forms()
  expect_s3_class(res, "data.frame")
  expect_named(res, c("code", "country", "country_code", "status", "name", "language"))
  expect_gt(nrow(res), 0L)
})

test_that("lei_registration_authorities returns expected format", {
  skip_on_cran()
  skip_on_ci()
  skip_if_offline()

  res <- lei_registration_authorities()
  expect_s3_class(res, "data.frame")
  expect_named(res, c("code", "international_name", "local_name", "website"))
  expect_gt(nrow(res), 0L)
})

test_that("lei_records works with filters", {
  skip_on_cran()
  skip_on_ci()
  skip_if_offline()

  res <- lei_records(fulltext = "Deutsche Bank", limit = 10L)
  expect_s3_class(res, "data.frame")
  expect_named(res, c("lei", "name", "value"))
  expect_gt(nrow(res), 0L)
})

test_that("lei_children returns expected format", {
  skip_on_cran()
  skip_on_ci()
  skip_if_offline()

  res <- lei_children("529900W18LQJJN6SJ336")
  expect_s3_class(res, "data.frame")
  expect_named(res, c("lei", "name", "value"))
  expect_gt(nrow(res), 0L)
})

test_that("lei_isins returns expected format", {
  skip_on_cran()
  skip_on_ci()
  skip_if_offline()

  res <- lei_isins("529900W18LQJJN6SJ336")
  expect_s3_class(res, "data.frame")
  expect_named(res, c("lei", "isin"))
  expect_gt(nrow(res), 0L)
})

test_that("lei_parent returns expected format", {
  skip_on_cran()
  skip_on_ci()
  skip_if_offline()

  res <- lei_parent("529900W18LQJJN6SJ336")
  expect_s3_class(res, "data.frame")
  expect_named(res, c("lei", "name", "value"))
  expect_gt(nrow(res), 0L)
})

test_that("lei_modifications returns expected format", {
  skip_on_cran()
  skip_on_ci()
  skip_if_offline()

  res <- lei_modifications("529900W18LQJJN6SJ336")
  expect_s3_class(res, "data.frame")
  expect_named(
    res,
    c(
      "lei",
      "record_type",
      "modification_type",
      "field",
      "date",
      "value_old",
      "value_new"
    )
  )
  expect_gt(nrow(res), 0L)
})

test_that("lei_fuzzy returns expected format", {
  skip_on_cran()
  skip_on_ci()
  skip_if_offline()

  res <- lei_fuzzy("Deutsch Bank", field = "entity.legalName")
  skip_if(is.null(res), "fuzzycompletions endpoint returned no results")
  expect_s3_class(res, "data.frame")
  expect_named(res, c("value", "lei"))
  expect_gt(nrow(res), 0L)
})

test_that("lei_autocomplete returns expected format", {
  skip_on_cran()
  skip_on_ci()
  skip_if_offline()

  res <- lei_autocomplete("Deutsche Bank")
  skip_if(is.null(res), "autocompletions endpoint returned no results")
  expect_s3_class(res, "data.frame")
  expect_named(res, c("value", "lei"))
  expect_gt(nrow(res), 0L)
})
