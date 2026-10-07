
# ss_parse_log() ----------------------------------------------------------

test_that("ss_parse_log() returns correct dimensions", {

  expect_equal(length(ss_parse_log(log_new, verbose = FALSE)), 4)
  expect_equal(
    length(
      Filter(Negate(is.null),
             ss_parse_log(
               log_new, verbose = FALSE,
               deployment_dates = FALSE, area_info = FALSE, config = FALSE))),
    1)
})

test_that("ss_parse_log() returns Errors and Warnings", {
  # 2 files in log folder
  expect_error(ss_read_log(paste0(path, "/test1")))

  # multiple deployment dates
  expect_warning(ss_read_log(paste0(path, "/test2"), verbose = FALSE))

  # multiple retrieval dates
  expect_warning(ss_read_log(paste0(path, "/test3"), verbose = FALSE))

  # deployment dates are in wrong order
  expect_error(ss_read_log(paste0(path, "/test4"), verbose = FALSE))

  # qualitative depth
  expect_warning(ss_read_log(paste0(path, "/test5"), verbose = FALSE))

  # unrecognized sensor
  expect_warning(ss_read_log(paste0(path, "/test6"), verbose = FALSE))

})
