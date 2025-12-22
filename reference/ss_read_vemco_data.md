# Import data from vemco csv files

Import data from vemco csv files

## Usage

``` r
ss_read_vemco_data(path, file_name)
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

## Author

Danielle Dempsey
