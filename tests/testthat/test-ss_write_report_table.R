# written with Claude Opus 5.5

test_that("ss_write_report_table() returns a row for a deployment", {
  tab <- ss_write_report_table(dat_extdata)

  expect_equal(nrow(tab), 1)
  expect_equal(
    colnames(tab),
    c("Station", "Deployment Date", "Retrieval Date", "Latitude", "Longitude",
      "Configuration", "Variables Measured")
  )
  expect_equal(tab$`Deployment Date`, "2019-05-30")
  expect_equal(
    strsplit(tab$`Variables Measured`, "\n")[[1]],
    c("temperature", "dissolved oxygen (% sat)", "depth", "tilt")
  )
})

test_that("ss_write_report_table() keep_waterbody and var_sep work", {
  tab <- ss_write_report_table(dat_extdata, keep_waterbody = TRUE, var_sep = ", ")

  expect_equal(tab$Waterbody, "Shoal Bay")
  expect_equal(tab$`Variables Measured`, "temperature, dissolved oxygen (% sat), depth, tilt")
})
