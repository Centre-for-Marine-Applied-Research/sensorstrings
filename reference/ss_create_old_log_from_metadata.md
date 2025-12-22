# Writes a deployment log from the metadata tracking sheet

Writes a deployment log from the metadata tracking sheet

## Usage

``` r
ss_create_old_log_from_metadata(
  path_metadata = NULL,
  sheet = "tracker",
  path_export,
  station,
  deployment_date,
  to_title = TRUE
)
```

## Arguments

- path_metadata:

  Path to the metadata tracking sheet (including the file name and
  extension). This must be a .xlsx file.

- sheet:

  Name of the tab with the deployment information.

- path_export:

  Path to the station deployment folder.

- station:

  Station name.

- deployment_date:

  Date of deployment as a character string in the format "YYYY-mm-dd"

- to_title:

  Logical argument indicating whether to convert the station name to
  title case. Default is `TRUE`. Set to `FALSE` for stations with
  capital letters within a word, e.g., McNabs Island.

## Value

Returns deployment log in .csv format.

## Details

Imports the NSDFA tracking sheet, filters for the station and date of
interest, re-formats into the deployment log format, and exports to the
Log folder.
