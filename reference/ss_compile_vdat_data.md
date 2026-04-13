# Format temperature data from VR2AR deployment

Compiles and formats temperature and depth data from VR2AR data
offloaded in the new .vdat format and exported with Fathom software.

## Usage

``` r
ss_compile_vdat_data(path, sn_table, deployment_dates, trim = TRUE)
```

## Arguments

- path:

  File path to the vdat folder. This folder should have one csv file
  that was extracted using Fathom software. Other file types in the
  folder will be ignored.

- sn_table:

  A data frame with three columns: `sensor_type`,
  `sensor_serial_number`, `depth`.

- deployment_dates:

  A data frame with two columns. The first column holds the deployment
  date (a Date object, POSIXct object, or character string in the order
  year, month, day), and the second column holds the retrieval date (a
  Date object, POSIXct object, or character string in the order year,
  month, day).

- trim:

  Logical value indicating whether to trim the data to the dates
  specified in `deployment_dates`. (Note: four hours are added to the
  retrieval date to account for AST, e.g., in case the sensor was
  retrieved after 20:00 AST, which is 00:00 UTC the next day.) Default
  is `trim = TRUE`.

## Value

Returns a tibble with the data compiled from the file in path/vdat.

## Details

The raw VR2AR data must be saved in a folder named vdat in csv format.
Folder name is not case-sensitive.

The device timestamp is used here. This may drift over time. Corrected
time stamp is included in the .vdat file, but the date is not always
appended.

## See also

Other compile:
[`ss_compile_aquameasure_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_aquameasure_data.md),
[`ss_compile_deployment_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_deployment_data.md),
[`ss_compile_hobo_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_hobo_data.md),
[`ss_compile_hobo_ph_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_hobo_ph_data.md),
[`ss_compile_vemco_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_compile_vemco_data.md),
[`ss_read_log_old()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_read_log_old.md)

## Author

Danielle Dempsey
