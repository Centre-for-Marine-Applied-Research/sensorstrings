# ss_read_vr2ar_data -------------------------------------------------------

test_that("ss_read_vr2ar_data() reads in all observations", {
  expect_equal(nrow(vr2ar1), 305)
})

test_that("ss_read_vr2ar_data() reads data when path includes file name", {
  expect_equal(vr2ar1, vr2ar2)
})


test_that("ss_read_vr2ar_data() report error for excel files", {
  expect_error(ss_read_vr2ar_data(path, "error.xls"))
  expect_error(ss_read_vr2ar_data(path, "error.xlsx"))
  expect_error(ss_read_vr2ar_data(paste0(path_vr2ar, "/12345678")))
})


# ss_compile_vr2ar_data ---------------------------------------------------

test_that("ss_compile_vr2ar_data() returns correct classes", {
  expect_equal(class(vr2_all$deployment_range), "character")
  expect_equal(class(vr2_all$timestamp_utc), c("POSIXct", "POSIXt"))
  expect_equal(class(vr2_all$sensor_type), "character")
  expect_equal(class(vr2_all$sensor_serial_number), "numeric")
  expect_equal(class(vr2_all$sensor_depth_at_low_tide_m), "numeric")
  expect_equal(class(vr2_all$sensor_depth_measured_m), "numeric")
  expect_equal(class(vr2_all$temperature_degree_c), "numeric")
})

test_that("ss_compile_vr2ar_data() reads in all observations", {
  expect_equal(nrow(vr2_all), 97)
  expect_equal(nrow(vr2_trim), 95)
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
