# Download deployment data from Google drive to the shared CMAR server

Download deployment data from Google drive to the shared CMAR server

## Usage

``` r
ss_download_data(path, station, depl_date)
```

## Arguments

- path:

  File path to the deployment folder on the CMAR server (as created by
  [`ss_set_up_folders()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_set_up_folders.md)).

- station:

  Station name. Should match the name of a folder on the CMAR Google
  drive, in CMAR - Coastal Monitoring Program/CMP Station Data

- depl_date:

  Deployment date (character string). Should be in the name of one of
  the deployment folders.

## Value

Downloads files from Google drive to the corresponding folder on the
CMAR server.
