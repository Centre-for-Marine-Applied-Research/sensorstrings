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

## See also

Other compile:
[`ss_compile_aquameasure_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_aquameasure_data.md),
[`ss_compile_deployment_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_deployment_data.md),
[`ss_compile_hobo_ph_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_hobo_ph_data.md),
[`ss_compile_vdat_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_vdat_data.md),
[`ss_compile_vemco_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_vemco_data.md),
[`ss_read_log_old()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_read_log_old.md)

## Author

Danielle Dempsey
