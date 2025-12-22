# Read in deployment log

The log must be saved in .csv, .xlsx or .xls format. Value checks are
applied in
[`ss_parse_log()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_parse_log.md).

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

Returns a a data frame of the deployment metadata. Option to parse the
information into a list using
[`ss_parse_log()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_parse_log.md).

## Details

"Old" log column names will be converted to the new standard (.e.,g
"Location_Description" will be replaced with "station").
