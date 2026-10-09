# written with Claude Opus 5.5

test_that("ss_export_county_files() writes csv and rds files to output_path", {
  out <- new_tmp_dir()
  on.exit(unlink(out, recursive = TRUE))

  dat <- dat_extdata[1:10, ]
  file_name <- paste0(Sys.Date(), "_halifax")

  rds <- suppressMessages(
    ss_export_county_files(dat, county = "halifax", output_path = out)
  )

  expect_equal(rds, file.path(out, paste0(file_name, ".rds")))
  expect_equal(readRDS(rds), dat)

  csv <- read.csv(file.path(out, paste0(file_name, ".csv")))
  expect_equal(nrow(csv), 10)
  # timestamp exported without the ISO "T...Z" formatting
  expect_false(any(grepl("T|Z", csv$timestamp_utc)))
})

test_that("ss_export_county_files() can export only the csv", {
  out <- new_tmp_dir()
  on.exit(unlink(out, recursive = TRUE))

  suppressMessages(ss_export_county_files(
    dat_extdata[1:10, ], county = "halifax", output_path = out, export_rds = FALSE
  ))
  expect_equal(list.files(out), paste0(Sys.Date(), "_halifax.csv"))
})
