# Create folders for the raw sensor string data from a given deployment

Create folders for the raw sensor string data from a given deployment

## Usage

``` r
ss_set_up_folders(path = NULL, station, depl_date, sensor_folders = FALSE)
```

## Arguments

- path:

  File path to where the deployment folder should be created.

- station:

  Station name.

- depl_date:

  Deployment start date as a character string.

- sensor_folders:

  Logical argument indicating whether to create the aquameasure, hobo,
  log, and vemco folders in the deployment folder. These folders may
  also be created using
  [`ss_download_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_download_data.md).

## Value

Creates the folder structure for storing raw sensor string data from a
single deployment.
