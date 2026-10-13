# written with Claude Opus 5.5

test_that("ss_export_county_files() writes csv and rds files to output_path", {
  out <- new_tmp_dir()
  on.exit(unlink(out, recursive = TRUE))

  dat <- dat_extdata[1:10, ]
  file_name <- paste0(Sys.Date(), "_halifax")

  out_file <- suppressMessages(
    ss_export_county_files(dat, county = "halifax", output_path = out)
  )

  expect_equal(out_file[2], file.path(out, paste0(file_name, ".rds")))
  expect_equal(readRDS(out_file[2]), dat)

  csv <- read.csv(file.path(out, paste0(file_name, ".csv")))
  expect_equal(nrow(csv), 10)

  # timestamp exported without the ISO "T...Z" formatting
  expect_false(any(grepl("T|Z", csv$timestamp_utc)))
})

test_that("ss_export_county_files() returns NULL for files that are not exported", {
  out <- new_tmp_dir()
  on.exit(unlink(out, recursive = TRUE))

  dat <- dat_extdata[1:10, ]
  file_name <- paste0(Sys.Date(), "_halifax")

  csv_rds <- suppressMessages(
    ss_export_county_files(dat, county = "halifax", output_path = out)
  )
  expect_length(csv_rds, 2)
  expect_true(grepl("*.csv$", csv_rds[1]))
  expect_true(grepl("*.rds$", csv_rds[2]))

  null_csv <- suppressMessages(
    ss_export_county_files(dat, county = "halifax", output_path = out, export_csv = FALSE)
  )
  expect_length(null_csv, 1)
  expect_true(grepl("*.rds$", null_csv))

  null_rds <- suppressMessages(
    ss_export_county_files(dat, county = "halifax", output_path = out, export_rds = FALSE)
  )
  expect_length(null_rds, 1)
  expect_true(grepl("*.csv$", null_rds))
})

