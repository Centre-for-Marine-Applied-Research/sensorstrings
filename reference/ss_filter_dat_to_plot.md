# Filter data before plotting to zoom in on interesting features

Called by
[`ss_open_trimdates_app()`](https://centre-for-marine-applied-research.github.io/sensorstrings/reference/ss_open_trimdates_app.md).

## Usage

``` r
ss_filter_dat_to_plot(
  dat,
  filter_to = c("start", "end", "custom"),
  period = "2 days",
  custom_start = NULL,
  custom_end = NULL
)
```

## Arguments

- dat:

  Data frame of sensor string data in wide format, as exported from
  [`ss_compile_deployment_data()`](https://centre-for-marine-applied-research.github.io/sensorstrings/reference/ss_compile_deployment_data.md).
  Must include columns timestamp\_, sensor_depth_at_low_tide_m,
  sensor_type, sensor-serial number, and the variables to plot (e.g.,
  temperature_degree_c).

- filter_to:

  Shortcut for specifying where to filter `dat` before plotting. Options
  are "start", "end", or "custom". Default is "start".

- period:

  Character string that can be converted to a `lubridate` period.
  Default is `"2 days"`.

- custom_start:

  Only required if `filter_to = "custom"`. POSIXct object indicating
  where the filtered data will begin.

- custom_end:

  Only required if `filter_to = "custom"`. POSIXct object indicating
  where the filtered data will end.

## Value

Returns `dat` filtered to the specified dates.

## Examples

``` r
# one week of hourly temperature data
dat <- data.frame(
  timestamp_utc = seq(
    as.POSIXct("2023-06-01 00:00", tz = "UTC"),
    as.POSIXct("2023-06-08 00:00", tz = "UTC"),
    by = "1 hour"
  ),
  sensor_depth_at_low_tide_m = 2,
  temperature_degree_c = 10
)

# the first 2 days (the default)
range(ss_filter_dat_to_plot(dat)$timestamp_utc)
#> [1] "2023-06-01 UTC" "2023-06-03 UTC"

# the last 12 hours
range(ss_filter_dat_to_plot(dat, filter_to = "end", period = "12 hours")$timestamp_utc)
#> [1] "2023-06-07 12:00:00 UTC" "2023-06-08 00:00:00 UTC"

# a custom window
dat_custom <- ss_filter_dat_to_plot(
  dat,
  filter_to = "custom",
  custom_start = as.POSIXct("2023-06-03 06:00", tz = "UTC"),
  custom_end = as.POSIXct("2023-06-03 18:00", tz = "UTC")
)
range(dat_custom$timestamp_utc)
#> [1] "2023-06-03 06:00:00 UTC" "2023-06-03 18:00:00 UTC"
```
