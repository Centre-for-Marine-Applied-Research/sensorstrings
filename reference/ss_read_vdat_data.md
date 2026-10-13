# Import data from VR2AR csv files exported from Fathom

Import data from VR2AR csv files exported from Fathom

## Usage

``` r
ss_read_vdat_data(path, file_name = NULL)
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

## Examples

``` r
path <- system.file("testdata", "vdat", package = "sensorstrings")

# folder and file name
vdat_raw <- ss_read_vdat_data(path, "VR2AR-69_555438.csv")
head(vdat_raw)
#>                V1                V2
#> 1  VEMCO DATA LOG             2.0.0
#> 2     RECORD TYPE             FIELD
#> 3   ATTITUDE_DESC Device Time (UTC)
#> 4  CLOCK_REF_DESC Device Time (UTC)
#> 5  CLOCK_SET_DESC Device Time (UTC)
#> 6 DATA_ERROR_DESC              Type
#>                                             V3
#> 1 fathom_connect-4.8.3-20260311-ba0e57-release
#> 2                                        FIELD
#> 3                                         Time
#> 4                                         Time
#> 5                                         Time
#> 6                                        Error
#>                                        V4                  V5          V6
#> 1 vdatapi-14.12.8-20260311-ac77b9-release                <NA>        <NA>
#> 2                                   FIELD               FIELD       FIELD
#> 3                         Time Offset (h) Time Correction (s)       Model
#> 4                         Time Offset (h) Time Correction (s)       Model
#> 5                         Time Offset (h) Time Correction (s)       Model
#> 6                                    Page              Offset Description
#>              V7                      V8                      V9    V10   V11
#> 1          <NA>                    <NA>                    <NA>   <NA>  <NA>
#> 2         FIELD                   FIELD                   FIELD  FIELD FIELD
#> 3 Serial Number              Tilt (deg)                    <NA>   <NA>  <NA>
#> 4 Serial Number     External Time (UTC) External Difference (s) Source  <NA>
#> 5 Serial Number Prior Device Time (UTC)    Prior Difference (s) Source  <NA>
#> 6          <NA>                    <NA>                    <NA>   <NA>  <NA>
#>     V12   V13   V14   V15   V16   V17   V18   V19   V20   V21   V22   V23   V24
#> 1  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>
#> 2 FIELD FIELD FIELD FIELD FIELD FIELD FIELD FIELD FIELD FIELD FIELD FIELD FIELD
#> 3  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>
#> 4  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>
#> 5  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>
#> 6  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>
#>     V25   V26
#> 1  <NA>  <NA>
#> 2 FIELD FIELD
#> 3  <NA>  <NA>
#> 4  <NA>  <NA>
#> 5  <NA>  <NA>
#> 6  <NA>  <NA>

# or the full path to the file
vdat_raw <- ss_read_vdat_data(file.path(path, "VR2AR-69_555438.csv"))
```
