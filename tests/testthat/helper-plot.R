# generated with Claude Opus 5.5

# Small synthetic data sets for the plot and label tests ------------------

# Wide sensor string data with one row per sensor per timestamp, similar to
# the output of ss_compile_deployment_data().
#   n_days: length of the record
#   depths: sensor_depth_at_low_tide_m values (one sensor per depth)
#   min_temp: the lowest temperature in the record
#   ts_col: name of the timestamp column
make_wq_wide <- function(
    n_days = 10,
    depths = c(10, 2, 5),
    min_temp = 4,
    ts_col = "timestamp_utc") {
  ts <- seq(
    as.POSIXct("2023-06-01 00:00:00", tz = "UTC"),
    by = "6 hours",
    length.out = n_days * 4 + 1
  )

  dat <- expand.grid(
    timestamp_utc = ts,
    sensor_depth_at_low_tide_m = depths,
    KEEP.OUT.ATTRS = FALSE
  )
  n <- nrow(dat)

  dat <- data.frame(
    county = "Halifax",
    station = "Test Station",
    deployment_range = "2023-Jun-01 to 2023-Jun-11",
    sensor_type = "aquameasure",
    sensor_serial_number = 600000 + match(
      dat$sensor_depth_at_low_tide_m, depths
    ),
    dat,
    dissolved_oxygen_percent_saturation = seq(90, 110, length.out = n),
    temperature_degree_c = seq(min_temp, min_temp + 10, length.out = n)
  )

  names(dat)[names(dat) == "timestamp_utc"] <- ts_col
  dat
}

# Long version of make_wq_wide()
make_wq_long <- function(...) ss_pivot_longer(make_wq_wide(...))

# Data with one timestamp column spanning n_days, for ss_xaxis_breaks()
make_span <- function(n_days, ts_col = "timestamp_utc") {
  start <- as.POSIXct("2020-01-01", tz = "UTC")
  dat <- data.frame(ts = c(start, start + n_days * 24 * 60 * 60))
  names(dat) <- ts_col
  dat
}

# Print a plot to a null device to make sure it renders
expect_renders <- function(p) {
  grDevices::pdf(NULL)
  on.exit(grDevices::dev.off(), add = TRUE)
  expect_no_error(print(p))
}

# Tests sometimes don't work if this is only in the test-file
dat_app <- make_wq_wide(n_days = 10)

