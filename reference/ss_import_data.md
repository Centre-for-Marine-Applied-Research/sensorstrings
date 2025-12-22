# Import Water Quality data from rds files

Import Water Quality data from rds files

## Usage

``` r
ss_import_data(input_path = NULL, county = "all")
```

## Arguments

- input_path:

  Path to the \*.rds files to be assembled. Default is the
  assembled_data folder on the CMAR R drive (user must be connected to
  the Perennia VPN).

- county:

  Vector of character string(s) indicating which county or counties for
  which to import data. For efficiency, the filter is applied to the
  file path, so the county name MUST be part of the file path. Defaults
  to all counties.
