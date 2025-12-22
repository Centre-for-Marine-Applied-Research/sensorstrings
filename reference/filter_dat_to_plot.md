# Filter data before plotting to zoom in on interesting features

Called by
[`ss_open_trimdates_app()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_open_trimdates_app.md).

## Usage

``` r
filter_dat_to_plot(
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
  [`ss_compile_deployment_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_deployment_data.md).
  Must include columns timestamp\_, sensor_depth_at_low_tide_m,
  sensor_type, sensor-serial number, and the variables to plot (e.g.,
  temperature_degree_c).

- filter_to:

  Shortcut for specifying where to filter `dat` before plotting. Options
  are "start", "end", or "custom".

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
