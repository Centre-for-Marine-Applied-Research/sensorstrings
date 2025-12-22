# Compile aquameasure, hobo, tidbit, and vemco data from a single deployment

Compile aquameasure, hobo, tidbit, and vemco data from a single
deployment

## Usage

``` r
ss_compile_deployment_data(
  path,
  trim = TRUE,
  ignore_sensors = NULL,
  depth_override = NULL
)
```

## Arguments

- path:

  File path to the log, aquameasure, hobo, tidbit, and/or vemco folders.

- trim:

  Logical value indicating whether to trim the data to the dates
  specified in `deployment_dates`. (Note: four hours are added to the
  retrieval date to account for AST, e.g., in case the sensor was
  retrieved after 20:00 AST, which is 00:00 UTC the next day.) Default
  is `trim = TRUE`.

- ignore_sensors:

  Vector of sensor serial numbers for sensors that are in the deployment
  log, but should NOT be compiled (e.g., data file missing).

- depth_override:

  An optional character string indicating which depth variable to
  compile. In some files (e.g., Borgles Island 2018-02-28), there is
  only one "Seawater depth" observation, but a full deployment of
  "Average seawater depth" observations. In this case, force the code to
  compile the average seawater depth with
  `depth_override = Average seawater depth`.

## Value

Returns a data frame of data from a sensor string deployment.

## Details

Reads the deployment log and then calls
[`ss_compile_aquameasure_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_aquameasure_data.md),
[`ss_compile_hobo_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_hobo_data.md),
and
[`ss_compile_vemco_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_vemco_data.md)
and returns the results in a single data frame.

aquameasure data must be in a folder named aquameasure, hobo data must
be in a folder named hobo, tidbit data must be in a folder named tidbit,
and vemco data must be in a folder name vemco (folder names are not case
sensitive). The aquameasure, hobo, tidbit, and vemco folders must be in
the same folder.

Columns with deployment details are added (e.g., county, waterbody,
latitude, longitude, station, lease, string_configuration).

## See also

Other compile:
[`ss_compile_aquameasure_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_aquameasure_data.md),
[`ss_compile_hobo_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_hobo_data.md),
[`ss_compile_hobo_ph_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_hobo_ph_data.md),
[`ss_compile_vemco_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_vemco_data.md),
[`ss_read_log_old()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_read_log_old.md)

## Author

Danielle Dempsey
