# Format temperature data from Vemco deployment

Compiles and formats temperature and seawater depth data from VR2AR
sensors.

## Usage

``` r
ss_compile_vemco_data(
  path,
  sn_table,
  deployment_dates,
  trim = TRUE,
  depth_override = NULL
)
```

## Arguments

- path:

  File path to the vemco folder. This folder should have one csv file
  that was extracted using Vue software. Other file types in the folder
  will be ignored.

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

- depth_override:

  An optional character string indicating which depth variable to
  compile. In some files (e.g., Borgles Island 2018-02-28), there is
  only one "Seawater depth" observation, but a full deployment of
  "Average seawater depth" observations. In this case, force the code to
  compile the average seawater depth with
  `depth_override = Average seawater depth`.

## Value

Returns a tibble with the data compiled from the file in path/vemco.

## Details

The raw vemco data must be saved in a folder named vemco in csv format.
Folder name is not case-sensitive.

If there are "Temperature" entries in the Description column, these will
be extracted and compiled. If there are no "Temperature" entries, but
there are "Average temperature" entries, these will be extracted and
compiled. Otherwise, the function will stop with an error message.

If there are "Seawater depth" entries in the Description column, these
will be extracted and compiled. If there are no "Seawater depth"
entries, but there are "Average seawater depth" entries, these will be
extracted and compiled. Otherwise, the function will stop with an error
message. (See argument `depth_override` for exception.)

## See also

Other compile:
[`ss_compile_aquameasure_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_aquameasure_data.md),
[`ss_compile_deployment_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_deployment_data.md),
[`ss_compile_hobo_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_hobo_data.md),
[`ss_compile_hobo_ph_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_hobo_ph_data.md),
[`ss_read_log_old()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_read_log_old.md)

## Author

Danielle Dempsey
