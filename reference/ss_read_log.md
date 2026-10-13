# Read in deployment log

The log must be saved in .csv, .xlsx or .xls format. Value checks are
applied in
[`ss_parse_log()`](https://centre-for-marine-applied-research.github.io/sensorstrings/reference/ss_parse_log.md).

## Usage

``` r
ss_read_log(
  path,
  parse = TRUE,
  verbose = TRUE,
  deployment_dates = TRUE,
  area_info = TRUE,
  sn_table = TRUE,
  config = TRUE
)
```

## Arguments

- path:

  File path to the log folder, or full path to the log file, include
  file name and extension. The function will stop with an Error if there
  is more than one eligible file (csv, .xlsx or .xls) in the log folder.

- parse:

  Logical argument indicating whether to parse log into a list used by
  `ss_compile_*` functions.

- verbose:

  Logical argument indicating whether to print messages when values are
  missing. Warnings will still be printed.

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

## Value

If `parse = TRUE` (the default), returns a list of deployment metadata
from
[`ss_parse_log()`](https://centre-for-marine-applied-research.github.io/sensorstrings/reference/ss_parse_log.md).
Otherwise returns a data frame of the metadata.

## Examples

``` r
# path to the deployment folder (which holds the Log folder)
path <- system.file("extdata", package = "sensorstrings")

# parsed into the list used by the ss_compile_*() functions
log <- ss_read_log(path)
log$sn_table
#>        log_sensor sensor_serial_number depth
#> 1     HOBO Pro V2             10755220     2
#> 2 aquaMeasure DOT               670364     5
#> 3           VR2AR               547109    15

# the log as a data frame
ss_read_log(path, parse = FALSE)
#>    county waterbody        station lease deployment_date retrieval_date
#> 1 Halifax Shoal Bay Borgles Island    NA      2019-05-30     2019-10-19
#> 2 Halifax Shoal Bay Borgles Island    NA      2019-05-30     2019-10-19
#> 3 Halifax Shoal Bay Borgles Island    NA      2019-05-30     2019-10-19
#>   deployment_latitude deployment_longitude retrieval_latitude
#> 1            44.77241            -62.72608           44.77241
#> 2            44.77241            -62.72608           44.77241
#> 3            44.77241            -62.72608           44.77241
#>   retrieval_longitude     sensor_type sensor_serial_number sensor_depth_m
#> 1           -62.72608     HOBO Pro V2             10755220              2
#> 2           -62.72608 aquaMeasure DOT               670364              5
#> 3           -62.72608           VR2AR               547109             15
#>   string_configuration
#> 1     sub-surface buoy
#> 2     sub-surface buoy
#> 3     sub-surface buoy

# or the full path to the log file
ss_read_log(
  file.path(path, "Log", "borgles_island_2019-05-30_log.csv"),
  parse = FALSE
)
#>    county waterbody        station lease deployment_date retrieval_date
#> 1 Halifax Shoal Bay Borgles Island    NA      2019-05-30     2019-10-19
#> 2 Halifax Shoal Bay Borgles Island    NA      2019-05-30     2019-10-19
#> 3 Halifax Shoal Bay Borgles Island    NA      2019-05-30     2019-10-19
#>   deployment_latitude deployment_longitude retrieval_latitude
#> 1            44.77241            -62.72608           44.77241
#> 2            44.77241            -62.72608           44.77241
#> 3            44.77241            -62.72608           44.77241
#>   retrieval_longitude     sensor_type sensor_serial_number sensor_depth_m
#> 1           -62.72608     HOBO Pro V2             10755220              2
#> 2           -62.72608 aquaMeasure DOT               670364              5
#> 3           -62.72608           VR2AR               547109             15
#>   string_configuration
#> 1     sub-surface buoy
#> 2     sub-surface buoy
#> 3     sub-surface buoy
```
