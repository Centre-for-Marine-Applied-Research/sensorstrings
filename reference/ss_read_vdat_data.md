# Import data from VR2AR csv files exported from Fathom

Import data from VR2AR csv files exported from Fathom

## Usage

``` r
ss_read_vdat_data(path, file_name)
```

## Arguments

- path:

  File path to the vdat folder, or full path to the data file including
  file name and extension.

- file_name:

  Name of the file to import, including file extension. Should be `NULL`
  if the file name is included in the `path` argument.

## Value

Returns a data frame of vr2ar data, with the same columns as in the
original file.

## Details

For VR2AR data offloaded in the new .vdat format and exported with
Fathom software. The data must be saved in csv format.

## Author

Danielle Dempsey
