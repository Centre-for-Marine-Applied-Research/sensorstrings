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

Returns a tibble with the data compiled from each of the hobo or tidbit
sensors.

## Details

Exported data must be saved in a folder named hobo_ph in csv format.

All of the csv files in the hobo_ph folder will be compiled.

The timestamp column must be in the order "mdY HMS".

If the timestamp is recorded in AST/ADT, it will be converted to UTC.

## See also

Other compile:
[`ss_compile_aquameasure_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_aquameasure_data.md),
[`ss_compile_deployment_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_deployment_data.md),
[`ss_compile_hobo_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_hobo_data.md),
[`ss_compile_vemco_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_vemco_data.md),
[`ss_read_log_old()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_read_log_old.md)

## Author

Danielle Dempsey
