# Open interactive plot

Open interactive plot

## Usage

``` r
ss_open_trimdates_app(
  dat,
  filter_to = c("start", "end", "custom"),
  period = "2 days",
  custom_start = NULL,
  custom_end = NULL,
  point_size = 2
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

- point_size:

  Size of points in the plot.

## Value

Opens a shiny app displaying an interactive plot of variables in `dat`,
coloured by depth.

## Examples

``` r
if (requireNamespace("shiny", quietly = TRUE) &&
    requireNamespace("plotly", quietly = TRUE)) {
  dat <- ss_compile_deployment_data(
    system.file("extdata", package = "sensorstrings"), trim = FALSE
  )

  # the app object is created here, and opens when printed or run
  app <- ss_open_trimdates_app(dat, filter_to = "end", period = "1 day")

  # the app is interactive, so only open it in an interactive session
  if (interactive()) shiny::runApp(app)

  # zoom in on a custom time window
  app2 <- ss_open_trimdates_app(
    dat,
    filter_to = "custom",
    custom_start = as.POSIXct("2019-05-30 12:00", tz = "UTC"),
    custom_end = as.POSIXct("2019-06-01 00:00", tz = "UTC")
  )
  if (interactive()) shiny::runApp(app2)
}
#> aquameasure data compiled
#> hobo data compiled
#> vemco data from sensor <<  547109  >> compiled: Temperature & Seawater depth
```
