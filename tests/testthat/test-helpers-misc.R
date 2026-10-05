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

# ss_coords_from_ddm_to_dd()
test_that("ss_coords_from_ddm_to_dd() returns correct coordinates", {
  expect_equal(
    round(ss_coords_from_ddm_to_dd(coords_ddm), digits = 5),
    c(45.36085, -61.40678, 44.43730, -64.25063)
  )

  expect_equal(
    round(ss_coords_from_ddm_to_dd(coords_ddm, west = FALSE), digits = 5),
    c(45.36085, 61.40678, 44.43730, 64.25063)
  )
})
