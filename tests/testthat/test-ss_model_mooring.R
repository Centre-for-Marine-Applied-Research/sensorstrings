# written with Claude Opus 5.5

# metadata supplied directly (metadata = NULL reads the CMAR R drive)
mooring_metadata <- data.frame(
  station = c("Borgles Island", "Borgles Island", "Borgles Island", "Other"),
  deployment_date = as.Date(c("2019-05-30", "2019-05-30", "2019-05-30", "2019-05-30")),
  instrument = c("Hobo Temp U22", "aquaMeasure DOT", "VR2AR reciever", "Hobo Temp U22"),
  sensor_depth_m = c(2, 5, 15, 1),
  sounding_m = c(18, 18, 18, 30),
  vr2ar_lug_height_above_seafloor_m = 1,
  anchor_type = "1 Railway Wheel",
  float_type = "14in centre hole tfloat"
)

test_that("ss_model_mooring() builds a mooring for the requested deployment only", {
  skip_if_not_installed("mooring")

  m <- ss_model_mooring("Borgles Island", "2019-05-30", metadata = mooring_metadata)

  expect_true(mooring::is.mooring(m))
  # anchor + 3 x (wire + instrument) + wire + float, one depth each;
  # the "Other" row is dropped
  depths <- mooring::depth(m)
  expect_length(depths, 9)
  expect_lt(max(depths), 18)
})

test_that("ss_model_mooring() raises a Warning for sounding shallower than the deepest sensor", {
  skip_if_not_installed("mooring")

  shallow <- mooring_metadata
  shallow$sounding_m <- 10

  expect_warning(
    m <- ss_model_mooring("Borgles Island", "2019-05-30", metadata = shallow),
    "sounding_m adjusted to 17"
  )
  expect_lt(max(mooring::depth(m)), 17)
})
