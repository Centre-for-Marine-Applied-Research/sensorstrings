# extract_file_extension()
test_that("extract_file_extension() identifies correct extension", {
  expect_equal(extract_file_extension("fake_file.csv"), "csv")
  expect_equal(extract_file_extension("fake.file.csv"), "csv")
  expect_equal(extract_file_extension("folder/fake_file.xlsx"), "xlsx")
  expect_equal(extract_file_extension("folder/fake_file"), "")
  expect_error(extract_file_extension(NULL))

  # vectorized
  expect_equal(
    extract_file_extension(c("a.csv", "b.XLSX", "noext")), c("csv", "xlsx", ""))
})

# written with Claude Opus 5.5
test_that("ss_export_path() builds the county/sub_folder path and file name", {
  out <- new_tmp_dir()
  on.exit(unlink(out, recursive = TRUE))

  dir.create(file.path(out, "halifax", "new"), recursive = TRUE)
  expect_equal(
    ss_export_path(dat_extdata, path = out),
    file.path(out, "halifax", "new", "borgles_island_2019-05-30.rds")
  )

  expect_error(ss_export_path(dat_extdata, path = out, sub_folder = "old"), "does not exist")
})

test_that("ss_import_path() builds the station/station_date path", {
  out <- new_tmp_dir()
  on.exit(unlink(out, recursive = TRUE))

  dir.create(file.path(out, "borgles_island", "borgles_island_2019-05-30"), recursive = TRUE)
  expect_equal(
    ss_import_path("Borgles Island", "2019-05-30", path = out),
    file.path(out, "borgles_island", "borgles_island_2019-05-30")
  )

  expect_error(ss_import_path("Borgles Island", "2020-01-01", path = out), "does not exist")
})

