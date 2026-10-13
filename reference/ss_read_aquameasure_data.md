# Import data from aquameasure csv files

Import data from aquameasure csv files

## Usage

``` r
ss_read_aquameasure_data(path, file_name = NULL)
```

## Arguments

- path:

  File path to the aquameasure folder, or full path to the data file
  including file name and extension.

- file_name:

  Name of the file to import, including file extension. Should be `NULL`
  if the file name is included in the `path` argument.

## Value

Returns a data frame of aquameasure data, with the same columns as in
the original file.

## Details

The aquameasure data must be saved in csv format.

## Examples

``` r
path <- system.file("extdata", "aquameasure", package = "sensorstrings")

# folder and file name
dat <- ss_read_aquameasure_data(path, "aquameasure-670364.csv")
head(dat)
#>                       Timestamp(UTC) Time Corrected(seconds)             Sensor
#> 1  209s after startup (time not set)                      NA aquaMeasure-670364
#> 2  353s after startup (time not set)                      NA aquaMeasure-670364
#> 3 1226s after startup (time not set)                      NA aquaMeasure-670364
#> 4 2143s after startup (time not set)                      NA aquaMeasure-670364
#> 5 3006s after startup (time not set)                      NA aquaMeasure-670364
#> 6 3875s after startup (time not set)                      NA aquaMeasure-670364
#>        Record Type Dissolved Oxygen Temperature Device Tilt Battery Voltage
#> 1      Device Tilt               NA          NA        90.4              NA
#> 2      Temperature               NA       22.68          NA              NA
#> 3 Dissolved Oxygen            100.5          NA          NA              NA
#> 4      Device Tilt               NA          NA        91.0              NA
#> 5      Device Tilt               NA          NA        91.1              NA
#> 6 Dissolved Oxygen            100.5          NA          NA              NA
#>   TimeSet Time Text
#> 1      NA   NA   NA
#> 2      NA   NA   NA
#> 3      NA   NA   NA
#> 4      NA   NA   NA
#> 5      NA   NA   NA
#> 6      NA   NA   NA

# or the full path to the file
dat <- ss_read_aquameasure_data(file.path(path, "aquameasure-670364.csv"))
```
