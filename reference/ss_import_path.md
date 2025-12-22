# Generate file path to import raw sensor string deployment data

Raw data must be saved in a folder path/station/station_yyyy-mm-dd.

## Usage

``` r
ss_import_path(station, depl_date, prov = "ns")
```

## Arguments

- station:

  Character string of the station name. Will be converted to lower case,
  and all spaces will be replaced with an underscore.

- depl_date:

  Character string of the deployment data in the order yyyy-mm-dd.

- prov:

  Character string indicating which province the deployment is from.
  Options are "ns" (the default) and "nb". This dicates the file path
  for where the data will be imported from on the CMAR R drive.

## Value

The file path for importing raw deployment data.
