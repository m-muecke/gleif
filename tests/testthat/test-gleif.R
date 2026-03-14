test_that("convert_camel_case works", {
  expect_identical(convert_camel_case("legalName"), "legal_name")
  expect_identical(convert_camel_case("entityID"), "entity_id")
  expect_identical(convert_camel_case("already_snake"), "already_snake")
  expect_identical(convert_camel_case("XMLParser"), "xml_parser")
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

test_that("lei_records validates inputs", {
  expect_error(lei_records(id = 123))
  expect_error(lei_records(simplify = "yes"))
  expect_error(lei_records(page_size = -1))
})

test_that("lei_records rejects id with filters", {
  expect_error(
    lei_records(id = "529900W18LQJJN6SJ336", legal_name = "foo"),
    "Cannot combine"
  )
})

test_that("lei_parents validates inputs", {
  expect_error(lei_parents(id = 123))
  expect_error(lei_parents(id = "foo", simplify = "yes"))
})

test_that("lei_issuers returns expected format", {
  skip_on_cran()
  skip_if_offline()
  res <- lei_issuers()
  expect_s3_class(res, "data.frame")
  expect_named(res, c("lei", "name", "marketing_name", "website", "accreditation_date"))
  expect_gt(nrow(res), 0L)
})

test_that("lei_regions returns expected format", {
  skip_on_cran()
  skip_if_offline()
  res <- lei_regions()
  expect_s3_class(res, "data.frame")
  expect_named(res, c("code", "language", "name"))
  expect_gt(nrow(res), 0L)
})

test_that("lei_records works with filters", {
  skip_on_cran()
  skip_if_offline()
  res <- lei_records(fulltext = "Deutsche Bank", page_size = 10L)
  expect_s3_class(res, "data.frame")
  expect_named(res, c("lei", "name", "value"))
  expect_gt(nrow(res), 0L)
})

test_that("lei_parents returns expected format", {
  skip_on_cran()
  skip_if_offline()
  res <- lei_parents("529900W18LQJJN6SJ336")
  expect_s3_class(res, "data.frame")
  expect_named(res, c("lei", "name", "value"))
  expect_gt(nrow(res), 0L)
})
