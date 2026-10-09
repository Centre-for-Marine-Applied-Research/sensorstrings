# written with Claude Opus 5.5

test_that("ss_create_log_from_metadata() writes a log that ss_read_log() can read", {
  out <- new_tmp_dir()
  on.exit(unlink(out, recursive = TRUE))

  log_path <- suppressMessages(ss_create_log_from_metadata(
    output_path = out,
    station = "borgles_island",
    deployment_date = "2019-05-30",
    path = metadata_xlsx
  ))

  log_file <- file.path(out, "log", "borgles_island_2019-05-30_log.csv")
  expect_true(file.exists(log_file))
  expect_equal(normalizePath(log_path), normalizePath(file.path(out, "log")))

  log <- ss_read_log(out, parse = FALSE)
  expect_equal(nrow(log), 3)
  expect_equal(unique(log$station), "Borgles Island")
  expect_true(all(log$deployment_latitude > 0))
  expect_true(all(log$deployment_longitude < 0))

  parsed <- ss_read_log(out, verbose = FALSE)
  expect_equal(length(parsed), 4)
})

test_that("ss_create_log_from_metadata() fills missing decimal degrees from the ddm columns", {
  out <- new_tmp_dir()
  on.exit(unlink(out, recursive = TRUE))

  # one sensor, with only the ddm coordinates filled in
  one_row_ddm <- readxl::read_excel(metadata_xlsx, sheet = "tracker", na = "")[1, ] |>
    dplyr::mutate(dplyr::across(
      c(deployment_latitude, deployment_longitude,
        retrieval_latitude, retrieval_longitude),
      ~ NA_real_
    ))
  # testthat function that mimics reading in one_row_ddm with read_excel()
  local_mocked_bindings(read_excel = function(...) one_row_ddm)

  suppressMessages(ss_create_log_from_metadata(
    output_path = out, station = "borgles_island",
    deployment_date = "2019-05-30", path = "not used"
  ))

  log <- ss_read_log(out, parse = FALSE)
  expect_equal(nrow(log), 1)
  expect_equal(log$deployment_latitude, 44.77242, tolerance = 1e-5)
  expect_equal(log$deployment_longitude, -62.72608, tolerance = 1e-5)
})

test_that("ss_create_log_from_metadata() gives Errors and Warnings", {
  out <- new_tmp_dir()
  on.exit(unlink(out, recursive = TRUE))

  expect_error(
    ss_create_log_from_metadata(
      out, "Not A Station", "2019-05-30", path = metadata_xlsx
    ),
    "not found"
  )
  expect_warning(
    suppressMessages(ss_create_log_from_metadata(
      out, "borgles_island", "2000-01-01", path = metadata_xlsx
    )),
    "No rows found"
  )
})
