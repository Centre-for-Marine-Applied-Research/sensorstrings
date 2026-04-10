# ss_read_vdat_data -------------------------------------------------------

test_that("ss_read_vdat_data() reads in all observations", {
  expect_equal(nrow(vdat1), 44)
})

test_that("ss_read_vr2ar_data() reads data when path includes file name", {
  expect_equal(vdat1, vdat2)
})


test_that("ss_read_vdat_data() report error for excel files", {
  expect_error(ss_read_vdat_data(path, "error.xls"))
  expect_error(ss_read_vdat_data(path, "error.xlsx"))
  expect_error(ss_read_vdat_data(paste0(path_vr2ar, "/12345678")))
})


# ss_compile_vr2ar_data ---------------------------------------------------

test_that("ss_compile_vdat_data() returns correct classes", {
  expect_equal(class(vdat_all$deployment_range), "character")
  expect_equal(class(vdat_all$timestamp_utc), c("POSIXct", "POSIXt"))
  expect_equal(class(vdat_all$sensor_type), "character")
  expect_equal(class(vdat_all$sensor_serial_number), "numeric")
  expect_equal(class(vdat_all$sensor_depth_at_low_tide_m), "numeric")
  expect_equal(class(vdat_all$sensor_depth_measured_m), "numeric")
  expect_equal(class(vdat_all$temperature_degree_c), "numeric")
})

test_that("ss_compile_vdat_data() reads in all observations", {
  expect_equal(nrow(vdat_all), 10)
  expect_equal(nrow(vdat_trim), 5)
})



# test_that("ss_compile_vr2ar_data() returns Error and Warnings", {
#   expect_error(
#     ss_compile_vr2ar_data(
#       path = path,
#       deployment_dates = deployment_dates,
#       sn_table = data.frame(sensor = "VR2AR", serial = "123456", depth = 6)
#     )
#   )
#
#   expect_error(
#     ss_compile_vr2ar_data(
#       path = path,
#       deployment_dates = data.frame(START = "2020-05-30", END = "2020-10-19"),
#       sn_table = sn_vr2
#     )
#   )
# })
#
