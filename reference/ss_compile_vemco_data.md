# Format temperature, depth, and tilt data from Vemco deployment

Compiles and formats temperature, seawater depth, and device tilt data
from VR2AR sensors processed with Vue software.

## Usage

``` r
ss_compile_vemco_data(
  path,
  sn_table,
  deployment_dates,
  trim = TRUE,
  depth_override = NULL
)
```

## Arguments

- path:

  File path to the vemco folder. This folder should have one csv file
  that was extracted using Vue software. Other file types in the folder
  will be ignored.

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

- depth_override:

  An optional character string indicating which depth variable to
  compile. In some files (e.g., Borgles Island 2018-02-28), there is
  only one "Seawater depth" observation, but a full deployment of
  "Average seawater depth" observations. In this case, force the code to
  compile the average seawater depth with
  `depth_override = "Average seawater depth"`.

## Value

Returns a tibble with the data compiled from the file in path/vemco.

## Details

The raw vemco data must be saved in a folder named vemco in csv format.
Folder name is not case-sensitive.

If there are "Temperature" entries in the Description column, these will
be extracted and compiled. If there are no "Temperature" entries, but
there are "Average temperature" entries, these will be extracted and
compiled. Otherwise, the function will stop with an error message.

If there are "Seawater depth" entries in the Description column, these
will be extracted and compiled. If there are no "Seawater depth"
entries, but there are "Average seawater depth" entries, these will be
extracted and compiled. Otherwise, the function will stop with an error
message. (See argument `depth_override` for exception.)

## Examples

``` r
path <- system.file("extdata", package = "sensorstrings")

sn_table <- data.frame(
  sensor_type = "VR2AR",
  sensor_serial_number = 547109,
  depth = 15
)

deployment_dates <- data.frame(START = "2019-05-30", END = "2019-10-19")

vemco <- ss_compile_vemco_data(
  path,
  sn_table = sn_table,
  deployment_dates = deployment_dates
)
#> vemco data from sensor <<  547109  >> compiled: Temperature & Seawater depth
head(vemco)
#> # A tibble: 6 × 8
#>   deployment_range          timestamp_utc       sensor_type sensor_serial_number
#>   <chr>                     <dttm>              <chr>                      <dbl>
#> 1 2019-May-30 to 2019-Oct-… 2019-05-30 18:10:00 vr2ar                     547109
#> 2 2019-May-30 to 2019-Oct-… 2019-05-30 18:13:00 vr2ar                     547109
#> 3 2019-May-30 to 2019-Oct-… 2019-05-30 18:17:00 vr2ar                     547109
#> 4 2019-May-30 to 2019-Oct-… 2019-05-30 18:25:00 vr2ar                     547109
#> 5 2019-May-30 to 2019-Oct-… 2019-05-30 18:28:00 vr2ar                     547109
#> 6 2019-May-30 to 2019-Oct-… 2019-05-30 18:32:00 vr2ar                     547109
#> # ℹ 4 more variables: sensor_depth_at_low_tide_m <dbl>,
#> #   sensor_depth_measured_m <dbl>, temperature_degree_c <dbl>,
#> #   tilt_degree <dbl>
```
