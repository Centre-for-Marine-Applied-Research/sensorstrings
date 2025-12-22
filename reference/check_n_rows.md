# Check number of rows of data file

Check number of rows of data file

## Usage

``` r
check_n_rows(dat, file_name, trimmed = TRUE)
```

## Arguments

- dat:

  Data frame. An Error will be returned if there are 0 rows of data.

- file_name:

  Name of file that is being checked, e.g., the csv file that was read
  in as `dat`. Used in the Error message to pinpoint the problematic
  file.

- trimmed:

  Logical value indicating if `dat` has been trimmed.

## Value

Returns an Error if there are no rows in `dat`.
