# Writes a deployment log from the metadata tracking sheet

Writes a deployment log from the metadata tracking sheet

## Usage

``` r
ss_create_log_from_metadata(
  output_path,
  station,
  deployment_date,
  path = NULL,
  sheet = "tracker",
  google_sheet = FALSE,
  google_sheet_link = NULL,
  to_title = TRUE
)
```

## Arguments

- output_path:

  Path to the station deployment folder.

- station:

  Station name.

- deployment_date:

  Date of deployment as a character string in the format "yyyy-mm-dd"

- path:

  Path to the metadata tracking sheet (including the file name and
  extension). This must be a .xlsx file.

- sheet:

  Name of the tab with the deployment information.

- google_sheet:

  Logical argument indicating whether metadata is stored in a google
  sheet. If `TRUE`, `path` is not required.

- google_sheet_link:

  Link the to metadata sheet on google drive. If `NULL`, the New
  Brunswick metadata sheet will be imported.

- to_title:

  Logical argument indicating whether to convert the station name to
  title case. Default is `TRUE`. Set to `FALSE` for stations with
  capital letters within a word, e.g., McNabs Island.

## Value

Returns deployment log in .csv format.

## Details

Imports the water quality metadata tracking sheet, filters for the
station and date of interest, re-formats into the deployment log format,
and exports to the Log folder.

## Examples

``` r
# The default (path = NULL) reads the metadata tracking sheet from the CMAR R
# drive. Here, path points to a small example sheet with the same "tracker"
# tab, and the log is written to a deployment folder in tempdir().
output_path <- file.path(tempdir(), "borgles_island_2019-05-30")
dir.create(output_path, showWarnings = FALSE)

ss_create_log_from_metadata(
  output_path = output_path,
  station = "borgles_island",
  deployment_date = "2019-05-30",
  path = system.file("extdata/metadata_tracking_example.xlsx", package = "sensorstrings")
)
#> borgles_island_2019-05-30_log.csv exported to /tmp/RtmpcbFS9g/borgles_island_2019-05-30/log

# the new log can be read with ss_read_log()
ss_read_log(output_path, parse = FALSE)
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

unlink(output_path, recursive = TRUE)

if (FALSE) {
  # google_sheet = TRUE reads the New Brunswick metadata Google Sheet (or the
  # sheet at google_sheet_link). Needs an internet connection, so not run.
  ss_create_log_from_metadata(
    output_path = tempdir(),
    station = "station name",
    deployment_date = "2024-05-01",
    google_sheet = TRUE
  )
}
```
