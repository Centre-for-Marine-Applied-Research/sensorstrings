# Extract information from old deployment log

Extract information from old deployment log

## Usage

``` r
ss_read_log_old(path, use_config = TRUE, path_config = NULL)
```

## Arguments

- path:

  File path to the Log folder, or full path to the log file, including
  file name and extension.

- use_config:

  Logical argument indicating whether to use a configuration table.
  Defaults to the water_quality_configuration_table.xslx on the CMAR R
  drive.

- path_config:

  File path (including name and extension) of the water quality
  configuration table. Default is water_quality_configuration_table.xlsx
  in the tracking_sheets folder. Data must be stored in an xlsx file in
  a tab named "deployments". Columns must be Waterbody, Station_Name,
  and Depl_Date. One and only one row must match the waterbody, station,
  and deployment date recorded in the Log. Options for the configuration
  column are sub-surface buoy, surface buoy, attached to gear, attached
  to fixed structure, floating dock, unknown, and calval. Use of the
  "unknown" entry is discouraged. HINT: for optimal speed, make sure the
  table is NOT filtered in the excel file.

  The `path_config` argument is ignored for new deployment logs that
  have an appropriate entry in the `Configuration` column.

  Configurations recorded as `NA` will be converted to "unknown" with a
  `Warning`.

  When there is no `Configuration` in the log and the deployment is not
  found in the configuration table, the configuration will berecoreded
  as "unknown" with a `Warning`.

  If more than one configuration is detected in the log or the
  configuration table, the function will stop with an `Error`.

## Value

Returns a list with 4 elements. `deployment_dates` is a data frame with
two columns: `start_date` (the date of deployment) and `end_date` (date
of retrieval). `area_info` is a data frame with five columns: `county`,
`waterbody`, `latitude`, `longitude`, `station`, and `lease`. `sn_table`
is a data frame with three columns: `log_sensor` (sensor name as
recorded in the log), `sensor_serial_number`, and `depth` (sensor depth
below the surface at low tide, from the Sensor_Depth column).
`string_configuration` is a character string indicating how the sensor
string was moored (i.e., whether the sensors float with the tide).

## Details

This function is deprecated.

The log must be saved in a folder called Log in .csv, .xlsx or .xls
format, and must include the following columns:

`Deployment_Waterbody`: waterbody where string was deployed

`Location_Description`: the station name

`Lease#`: If located on an aquaculture site, the lease number (NA
otherwise)

`Deployment`: deployment date, in the order "Ymd"

`Retrieval`: retrieval date, in the order "Ymd"

`Logger_Latitude`: The latitude at which the string was deployed

`Logger_Longitude` The longitude at which the string was deployed (must
be a negative value)

`Logger_Model` The type of sensor; see below for options

`Serial#` The sensor serial number

`Sensor_Depth`: Depth at which the sensor was deployed

All other columns will be ignored.

Entries in the `Logger_Model` column must include the string
"aquameasure", "hobo", "tidbit", or "vr2ar" (not case sensitive).

The function will stop with an Error if there is more than one eligible
file (csv, .xlsx or .xls) in the Log folder.

The function will stop with an Error if there if the `Logger_Longitude`
is a positive value.

A Warning message is printed to the console when the function does not
recognize a sensor in the log.

A message is printed to the console when hobo, aquameasure, or vemco
sensors are not found in the log.

A message is printed to the console if there is more than one unique
entry in `Deployment_Waterbody`, `Location_Description`, `Deployment`,
`Retrieval`, `Logger_Latitude`, or `Logger_Longitude`.

## See also

Other compile:
[`ss_compile_aquameasure_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_aquameasure_data.md),
[`ss_compile_deployment_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_deployment_data.md),
[`ss_compile_hobo_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_hobo_data.md),
[`ss_compile_hobo_ph_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_hobo_ph_data.md),
[`ss_compile_vdat_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_vdat_data.md),
[`ss_compile_vemco_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_vemco_data.md)

## Author

Danielle Dempsey
