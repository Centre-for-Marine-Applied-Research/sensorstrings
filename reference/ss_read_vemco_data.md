# Import data from vemco csv files

Import data from vemco csv files

## Usage

``` r
ss_read_vemco_data(path, file_name = NULL)
```

## Arguments

- path:

  File path to the vemco folder, or full path to the data file including
  file name and extension.

- file_name:

  Name of the file to import, including file extension. Should be `NULL`
  if the file name is included in the `path` argument.

## Value

Returns a data frame of vemco data, with the same columns as in the
original file.

## Details

The Vemco data must be saved in csv format.

## Examples

``` r
path <- system.file("extdata", "vemco", package = "sensorstrings")

# folder and file name
vemco_raw <- ss_read_vemco_data(path, "vemco-547109.csv")
head(vemco_raw)
#>   Date and Time (UTC)     Receiver    Description  Data Units
#> 1    2019-05-30 18:06 VR2AR-547109          Noise 207.6    mV
#> 2    2019-05-30 18:10 VR2AR-547109     Tilt angle    89     °
#> 3    2019-05-30 18:13 VR2AR-547109    Temperature  13.6    °C
#> 4    2019-05-30 18:17 VR2AR-547109 Seawater depth     0     m
#> 5    2019-05-30 18:21 VR2AR-547109          Noise 178.3    mV
#> 6    2019-05-30 18:25 VR2AR-547109     Tilt angle    84     °

# or the full path to the file
vemco_raw <- ss_read_vemco_data(file.path(path, "vemco-547109.csv"))
```
