# Compile data from aquameasure sensors

Compile and format temperature, dissolved oxygen, salinity, chlorophyll
(blue and red), and/or device depth and tilt data from aquameasure
sensors.

## Usage

``` r
ss_compile_aquameasure_data(path, sn_table, deployment_dates, trim = TRUE)
```

## Arguments

- path:

  File path to the hobo or tidbit folder.

- sn_table:

  A data frame with three columns: `sensor_type`,
  `sensor_serial_number`, `depth`.

- deployment_dates:

  A data frame with two columns. The first column holds the deployment
  date (a Date object, POSIXct object, or character string in the order
  year, month, day), and the second column holds the retrieval date (a
  Date object, POSIXct object, or character string in the order year,
  month, day).

- trim:

  Logical value indicating whether to trim the data to the dates
  specified in `deployment_dates`. (Note: four hours are added to the
  retrieval date to account for AST, e.g., in case the sensor was
  retrieved after 20:00 AST, which is 00:00 UTC the next day.) Default
  is `trim = TRUE`.

## Value

Returns a tibble with the compiled data from each of the aquameasure
files saved in path/aquameasure.

## Details

The raw aquameasure data must be saved in a folder named aquameasure in
csv format. Folder name is not case-sensitive.

Rows with `undefined` and `... (time not set)` values in the
`Timestamp(UTC)` column are filtered out.

The timestamp columns must be in the order "ymd IMS p", "Ymd IMS p",
"Ymd HM", "Ymd HMS", "dmY HM", or "dmY HMS".

"ERR" values are converted to `-111` (to distinguish from sensor error
value of -101.5).

## Examples

``` r
path <- system.file("extdata", package = "sensorstrings")

sn_table <- data.frame(
  sensor_type = "aquameasure",
  sensor_serial_number = 670364,
  depth = 5
)

deployment_dates <- data.frame(START = "2019-05-30", END = "2019-10-19")

am <- ss_compile_aquameasure_data(
  path,
  sn_table = sn_table,
  deployment_dates = deployment_dates, trim = FALSE
)
#> aquameasure data compiled
head(am)
#> # A tibble: 6 × 8
#>   deployment_range          timestamp_utc       sensor_type sensor_serial_number
#>   <chr>                     <dttm>              <chr>                      <dbl>
#> 1 2019-May-30 to 2019-Oct-… 2018-02-28 17:43:00 aquameasure               670364
#> 2 2019-May-30 to 2019-Oct-… 2018-02-28 19:35:00 aquameasure               670364
#> 3 2019-May-30 to 2019-Oct-… 2018-02-28 21:37:00 aquameasure               670364
#> 4 2019-May-30 to 2019-Oct-… 2018-02-28 23:39:00 aquameasure               670364
#> 5 2019-May-30 to 2019-Oct-… 2018-03-01 01:41:00 aquameasure               670364
#> 6 2019-May-30 to 2019-Oct-… 2018-03-01 05:35:00 aquameasure               670364
#> # ℹ 4 more variables: sensor_depth_at_low_tide_m <dbl>,
#> #   dissolved_oxygen_percent_saturation <dbl>, temperature_degree_c <dbl>,
#> #   tilt_degree <dbl>
```
