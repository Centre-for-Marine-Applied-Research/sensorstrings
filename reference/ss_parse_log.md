# Extract information from deployment log

The function will attempt to parse the following columns: `county`,
`waterbody`,`station`, `lease`, `deployment_date`, `retrieval_date`,
`deployment_latitude`, `deployment_longitude`, `sensor_type`,
`sensor_serial_number`, `sensor_depth_m`. Missing information will be
filled in with `NA`.

## Usage

``` r
ss_parse_log(
  log,
  deployment_dates = TRUE,
  area_info = TRUE,
  sn_table = TRUE,
  config = TRUE,
  verbose = TRUE
)
```

## Arguments

- log:

  Log data frame, e.g., as exported from
  [`ss_read_log()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_read_log.md).

- deployment_dates:

  Logical argument indicating whether to parse and return the deployment
  and retrieval dates.

- area_info:

  Logical argument indicating whether to parse and return the location
  details.

- sn_table:

  Logical argument indicating whether to parse and return the serial
  numbers and sensor depth.

- config:

  Logical argument indicating whether to parse and return the string
  configuration.

- verbose:

  Logical argument indicating whether to print messages when values are
  missing. Warnings will still be printed.

## Value

Returns a list with up to 4 elements. `deployment_dates` is a data frame
with two columns: `start_date` and `end_date`. `area_info` is a data
frame with five columns: `county`, `waterbody`, `latitude`, `longitude`,
`station`, and `lease`. `sn_table` is a data frame with three columns:
`log_sensor` (sensor name as recorded in the log),
`sensor_serial_number`, and `depth`. `string_configuration` is a
character string indicating how the sensor string was moored.

## Details

Old log column names will also be accepted.

If `verbose = TRUE`, a message will be printed if there is more than one
unique entry in `waterbody`, `station`, `deployment_date`,
`retrieval_date`, `deployment_latitude`, or `deployment_longitude`.

Entries in the `sensor_type` column must include the string
"aquameasure", "hobo", "tidbit", or "vr2ar" (not case sensitive).

A Warning message is printed when the function does not recognize a
sensor in the log.

Code will stop with an error if `deployment_longitude` is a positive
value.
