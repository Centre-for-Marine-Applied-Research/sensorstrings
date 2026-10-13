# Import data from hobo or tidbit csv file

Import data from hobo or tidbit csv file

## Usage

``` r
ss_read_hobo_data(path, file_name = NULL)
```

## Arguments

- path:

  File path to the hobo folder, or full path to the data file including
  file name and extension.

- file_name:

  Name of the file to import, including file extension. Should be `NULL`
  if the file name is included in the `path` argument.

## Value

Returns a data frame of hobo or tidbit data, with the same columns as in
the original file.

## Details

The data must be saved in csv format.

## Examples

``` r
path <- system.file("extdata", "hobo", package = "sensorstrings")

# folder and file name
dat <- ss_read_hobo_data(path, "10755220.csv")
head(dat)
#>    # Date Time, GMT+00:00 Temp, °C (LGR S/N: 10755220, SEN S/N: 10755220) V4
#> 1  4     2019-05-30 21:00                                           6.661 NA
#> 2  8      2019-05-31 1:00                                           7.695 NA
#> 3 12      2019-05-31 5:00                                           7.569 NA
#> 4 16      2019-05-31 9:00                                           6.509 NA
#> 5 20     2019-05-31 13:00                                           6.788 NA
#> 6 24     2019-05-31 17:00                                           6.839 NA
#>   Coupler Attached (LGR S/N: 10755220) Host Connected (LGR S/N: 10755220)
#> 1                                   NA                                 NA
#> 2                                   NA                                 NA
#> 3                                   NA                                 NA
#> 4                                   NA                                 NA
#> 5                                   NA                                 NA
#> 6                                   NA                                 NA
#>   Stopped (LGR S/N: 10755220) End Of File (LGR S/N: 10755220)
#> 1                                                            
#> 2                                                            
#> 3                                                            
#> 4                                                            
#> 5                                                            
#> 6                                                            

# or the full path to the file
dat <- ss_read_hobo_data(file.path(path, "10755220.csv"))
```
