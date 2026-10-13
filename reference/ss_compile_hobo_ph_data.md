# Compile and format data from hobo pH sensors (MX2501)

Compile and format data from hobo pH sensors (MX2501)

## Usage

``` r
ss_compile_hobo_ph_data(
  path,
  sn_table,
  deployment_dates,
  tz_check = FALSE,
  trim = TRUE
)
```

## Arguments

- path:

  File path to the hobo_ph folder.

- sn_table:

  A data frame with three columns: `sensor_type`,
  `sensor_serial_number`, `depth`.

- deployment_dates:

  A data frame with two columns. The first column holds the deployment
  date (a Date object, POSIXct object, or character string in the order
  year, month, day), and the second column holds the retrieval date (a
  Date object, POSIXct object, or character string in the order year,
  month, day).

- tz_check:

  Logical argument indicating whether to check if the timestamp column
  is in utc. If `TRUE`, a warning will be printed if the timezone is NOT
  utc.

- trim:

  Logical value indicating whether to trim the data to the dates
  specified in `deployment_dates`. (Note: four hours are added to the
  retrieval date to account for AST, e.g., in case the sensor was
  retrieved after 20:00 AST, which is 00:00 UTC the next day.) Default
  is `trim = TRUE`.

## Value

Returns a tibble with the data compiled from each of the hobo pH
sensors.

## Details

Exported data must be saved in a folder named hobo_ph in csv format.

All of the csv files in the hobo_ph folder will be compiled.

The timestamp column must be in the order "mdY HMS", “Ymd HMS”, or
“Ymd”.

If the timestamp is recorded in AST/ADT, it will be converted to UTC.

## Examples

``` r
# path holds a folder called hobo_ph
path <- system.file("testdata", package = "sensorstrings")

sn_table <- data.frame(
  sensor_type = "hobo ph",
  sensor_serial_number = 22058687,
  depth = 1
)

deployment_dates <- data.frame(START = "2025-03-08", END = "2025-03-09")

hobo_ph <- ss_compile_hobo_ph_data(
  path,
  sn_table = sn_table,
  deployment_dates = deployment_dates
)
#> hobo_ph data compiled
head(hobo_ph)
#> # A tibble: 6 × 7
#>   deployment_range          timestamp_utc       sensor_type sensor_serial_number
#>   <chr>                     <dttm>              <chr>                      <dbl>
#> 1 2025-Mar-08 to 2025-Mar-… 2025-03-08 01:56:06 hobo ph                 22058687
#> 2 2025-Mar-08 to 2025-Mar-… 2025-03-08 02:06:06 hobo ph                 22058687
#> 3 2025-Mar-08 to 2025-Mar-… 2025-03-09 02:16:06 hobo ph                 22058687
#> 4 2025-Mar-08 to 2025-Mar-… 2025-03-09 02:26:06 hobo ph                 22058687
#> 5 2025-Mar-08 to 2025-Mar-… 2025-03-09 02:36:06 hobo ph                 22058687
#> 6 2025-Mar-08 to 2025-Mar-… 2025-03-09 02:46:06 hobo ph                 22058687
#> # ℹ 3 more variables: sensor_depth_at_low_tide_m <dbl>, ph_ph <dbl>,
#> #   temperature_degree_c <dbl>
```
