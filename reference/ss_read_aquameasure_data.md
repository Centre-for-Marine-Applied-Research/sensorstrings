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

## Author

Danielle Dempsey
