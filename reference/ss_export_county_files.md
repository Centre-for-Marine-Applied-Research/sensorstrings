# Export data into a csv and/or rds file

Export data into a csv and/or rds file

## Usage

``` r
ss_export_county_files(
  dat,
  county = "",
  output_path = NULL,
  export_csv = TRUE,
  export_rds = TRUE
)
```

## Arguments

- dat:

  Dataframe to be exported, e.g., output from `export_county_data()`.

- county:

  County name. Will be appended with today's date as the name of the
  output file.

- output_path:

  Path to where there assembled file(s) will be exported. The default
  will export the csv file to the open_data folder and the rds file to
  the processed_data/assembled_data folder (both on the R drive). For
  custom `output_path` entries, the csv and rds files will be exported
  to the same folder.

- export_csv:

  Logical argument indicating whether the data should be exported as a
  csv file. File name will be county_todays-date.csv. Default is `TRUE`.

  Note: `timestamp_utc` is converted to a character before exporting to
  remove UTC formatting (2018-12-23T05:00:00Z). When re-imported into R,
  the UTC timezone can be added using
  [`lubridate::force_tz()`](https://lubridate.tidyverse.org/reference/force_tz.html).

  NAs are exported as blank cells at the request of the Open Data
  Portal.

- export_rds:

  Logical argument indicating whether the assembled data should be
  exported as a \*.rds file. File name will be county_todays-date.rds.
  Default is `TRUE`.

## Value

Exports `dat` as a csv and/or rds file.

## Author

Danielle Dempsey
