# written with Claude Opus 5.5

test_that("ss_import_data() reads all rds files, or only the requested county", {
  out <- new_tmp_dir()
  on.exit(unlink(out, recursive = TRUE))

  saveRDS(dat_extdata[1:10, ], file.path(out, "2025-01-01_halifax.rds"))
  saveRDS(
    dplyr::mutate(dat_extdata[11:15, ], county = "Lunenburg"),
    file.path(out, "2025-01-01_lunenburg.rds")
  )

  all <- suppressMessages(ss_import_data(out))
  expect_equal(nrow(all), 15)

  hfx <- suppressMessages(ss_import_data(out, county = "Halifax"))
  expect_equal(nrow(hfx), 10)
  expect_equal(unique(hfx$county), "Halifax")
})
