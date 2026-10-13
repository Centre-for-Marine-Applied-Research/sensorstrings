# Compile and format data from hobo or tidbit sensors

Compile and format data from hobo or tidbit sensors

## Usage

``` r
ss_compile_hobo_data(
  path,
  sn_table,
  deployment_dates,
  trim = TRUE,
  sensor_make = "hobo"
)
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

- sensor_make:

  Character string indicating whether data to be compiled is from hobo
  sensors (default) or tidbit sensors. Will be used to fill in the
  `sensor_type` column of the output file. The raw file format is the
  same for each type of sensor.

## Value

Returns a tibble with the data compiled from each of the hobo or tidbit
sensors.

## Details

This code does not correct dissolved oxygen data for salinity.

Exported hobo and tidbit data must be saved in a folder named hobo in
csv format.

All of the csv files in the hobo or tidbit folder will be compiled.

The timestamp columns must be in the order "ymd IMS p", "Ymd IMS p",
"Ymd HM", "Ymd HMS", "dmY HM", or "dmY HMS".

## Examples

``` r
path <- system.file("extdata", package = "sensorstrings")

sn_table <- data.frame(
  sensor_type = "hobo",
  sensor_serial_number = 10755220,
  depth = 2
)

deployment_dates <- data.frame(START = "2019-05-30", END = "2019-10-19")

hobo <- ss_compile_hobo_data(
  path,
  sn_table = sn_table,
  deployment_dates = deployment_dates
)
#> hobo data compiled
head(hobo)
#> # A tibble: 6 × 6
#>   deployment_range          timestamp_utc       sensor_type sensor_serial_number
#>   <chr>                     <dttm>              <chr>                      <dbl>
#> 1 2019-May-30 to 2019-Oct-… 2019-05-30 21:00:00 hobo                    10755220
#> 2 2019-May-30 to 2019-Oct-… 2019-05-31 01:00:00 hobo                    10755220
#> 3 2019-May-30 to 2019-Oct-… 2019-05-31 05:00:00 hobo                    10755220
#> 4 2019-May-30 to 2019-Oct-… 2019-05-31 09:00:00 hobo                    10755220
#> 5 2019-May-30 to 2019-Oct-… 2019-05-31 13:00:00 hobo                    10755220
#> 6 2019-May-30 to 2019-Oct-… 2019-05-31 17:00:00 hobo                    10755220
#> # ℹ 2 more variables: sensor_depth_at_low_tide_m <dbl>,
#> #   temperature_degree_c <dbl>
```
