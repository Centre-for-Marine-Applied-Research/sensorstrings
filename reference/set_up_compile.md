# Set up parameters, Errors, and Warnings for the `compile_**` functions

Set up parameters, Errors, and Warnings for the `compile_**` functions

## Usage

``` r
set_up_compile(path, sn_table, deployment_dates, sensor_make)
```

## Arguments

- path:

  File path to the folder with the aquameasure, hobo, tidbit, or vemco
  folder.

- sn_table:

  A data frame with three columns: `sensor_type`,
  `sensor_serial_number`, `depth`.

- deployment_dates:

  A data frame with two columns. The first column holds the deployment
  date (a Date object, POSIXct object, or character string in the order
  year, month, day), and the second column holds the retrieval date (a
  Date object, POSIXct object, or character string in the order year,
  month, day).

- sensor_make:

  Make of the sensor to be compiled. Should match the name of the folder
  with the raw data files. Most common entries will be "aquameasure",
  "hobo", or "vemco".

## Value

Returns a list of parameters used in the `compile_**` functions: final
path to the folder of interest, deployment dates, vector of files in the
folder, and `sn_table`.

## Details

A column named `sensor_type` is added to `sn_table`, with values of
`sensor_make`. The `sensor_type` column is added to the compiled data
(e.g., "aquameasure", "hobo", "vr2ar" vs "HOBO PRO V2" or "aquaMeasure
DOT").

Returns Errors and Warnings if the expected files are not found on the
`path`.
