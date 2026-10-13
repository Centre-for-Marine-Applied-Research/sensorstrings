# Format temperature, depth, and tilt data from VR2AR (vdat) deployment

Compiles and formats temperature, depth, and tilt data from VR2AR data
offloaded in the new .vdat format and exported with Fathom software.

## Usage

``` r
ss_compile_vdat_data(path, sn_table, deployment_dates, trim = TRUE)
```

## Arguments

- path:

  File path to the vdat folder. This folder should have one csv file
  that was extracted using Fathom software. Other file types in the
  folder will be ignored.

- sn_table:

  A data frame with three columns: `sensor_type`,
  `sensor_serial_number`, `depth`.

- deployment_dates:

  A data frame with two columns. The first column holds the deployment
  date (a Date object, POSIXct object, or character string in the order
  year, month, day), and the second column holds the retrieval date (a
  Date object, POSIXct object, or character string in the order year,
  month, day).

- trim:

  Logical value indicating whether to trim the data to the dates
  specified in `deployment_dates`. (Note: four hours are added to the
  retrieval date to account for AST, e.g., in case the sensor was
  retrieved after 20:00 AST, which is 00:00 UTC the next day.) Default
  is `trim = TRUE`.

## Value

Returns a tibble with the data compiled from the file in path/vdat.

## Details

The raw VR2AR data must be saved in a folder named vdat in csv format.
Folder name is not case-sensitive.

The device timestamp is used here. This may drift over time. Corrected
time stamp is included in the .vdat file, but the date is not always
appended.

## Examples

``` r
# full path to a VR2AR file processed with Fathom (vdat)
path <- system.file(
  "testdata", "vdat", "VR2AR-69_555438.csv", package = "sensorstrings"
)

sn_table <- data.frame(
  sensor_type = "VR2AR-69",
  sensor_serial_number = 555438,
  depth = 5
)

deployment_dates <- data.frame(START = "2019-05-30", END = "2019-10-19")

vdat <- ss_compile_vdat_data(
  path,
  sn_table = sn_table,
  deployment_dates = deployment_dates,
  trim = FALSE
)
#> vdat data from sensor <<  555438  >> compiled
head(vdat)
#> # A tibble: 6 × 8
#>   deployment_range          timestamp_utc       sensor_type sensor_serial_number
#>   <chr>                     <dttm>              <chr>                      <dbl>
#> 1 2019-May-30 to 2019-Oct-… 2019-05-29 18:00:00 vr2ar-69                  555438
#> 2 2019-May-30 to 2019-Oct-… 2019-05-30 19:00:00 vr2ar-69                  555438
#> 3 2019-May-30 to 2019-Oct-… 2019-05-30 04:00:00 vr2ar-69                  555438
#> 4 2019-May-30 to 2019-Oct-… 2019-10-30 05:00:00 vr2ar-69                  555438
#> 5 2019-May-30 to 2019-Oct-… 2019-10-30 06:00:00 vr2ar-69                  555438
#> 6 2019-May-30 to 2019-Oct-… 2019-10-19 07:00:00 vr2ar-69                  555438
#> # ℹ 4 more variables: sensor_depth_at_low_tide_m <dbl>,
#> #   sensor_depth_measured_m <dbl>, temperature_degree_c <dbl>,
#> #   tilt_degree <dbl>
```
