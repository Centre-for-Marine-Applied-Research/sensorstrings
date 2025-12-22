# Compile data from aquameasure sensors

Compile and format temperature, dissolved oxygen, salinity, and/or
device depth data from aquameasure sensors.

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

## See also

Other compile:
[`ss_compile_deployment_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_deployment_data.md),
[`ss_compile_hobo_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_hobo_data.md),
[`ss_compile_hobo_ph_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_hobo_ph_data.md),
[`ss_compile_vemco_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_vemco_data.md),
[`ss_read_log_old()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_read_log_old.md)

## Author

Danielle Dempsey
