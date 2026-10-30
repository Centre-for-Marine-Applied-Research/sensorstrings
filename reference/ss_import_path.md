# Generate file path to import raw sensor string deployment data

Raw data must be saved in a folder path/station/station_yyyy-mm-dd.

## Usage

``` r
ss_import_path(station, depl_date, prov = "ns", path = NULL)
```

## Arguments

- station:

  Character string of the station name. Will be converted to lower case,
  and all spaces will be replaced with an underscore.

- depl_date:

  Character string of the deployment date in the order yyyy-mm-dd.

- prov:

  Character string indicating which province the deployment is from.
  Options are "ns" (the default) and "nb". This dictates the file path
  for where the data will be imported from on the CMAR R drive.

- path:

  Partial path to where data is imported from. The final path is
  path/station/station_depl_date. If `NULL` (the default), this will be
  a folder on the CMAR shared drive, dictated by the value of `prov`.

## Value

The file path for importing raw deployment data.

## Examples

``` r
# The default (path = NULL) points to the station_folders folder on the CMAR R
# drive. Here, path is a folder in tempdir() set up with ss_set_up_folders().
path <- file.path(tempdir(), "station_folders")
dir.create(path, showWarnings = FALSE)

ss_set_up_folders(station = "Borgles Island", depl_date = "2019-05-30", path_output = path)
#> Created folder << borgles_island >> in << /tmp/RtmpcbFS9g/station_folders >>

ss_import_path("Borgles Island", "2019-05-30", path = path)
#> [1] "/tmp/RtmpcbFS9g/station_folders/borgles_island/borgles_island_2019-05-30"

unlink(path, recursive = TRUE)
```
