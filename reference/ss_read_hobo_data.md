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

## Author

Danielle Dempsey
