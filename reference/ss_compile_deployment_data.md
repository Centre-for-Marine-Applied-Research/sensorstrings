# Compile Water Quality data from a sensor string deployment

Compile Water Quality data from a sensor string deployment

## Usage

``` r
ss_compile_deployment_data(
  path,
  trim = TRUE,
  ignore_sensors = NULL,
  depth_override = NULL
)
```

## Arguments

- path:

  File path to the log, aquameasure, hobo, hobo_ph, vdat, and/or vemco
  folders.

- trim:

  Logical value indicating whether to trim the data to the dates
  specified in `deployment_dates`. (Note: four hours are added to the
  retrieval date to account for AST, e.g., in case the sensor was
  retrieved after 20:00 AST, which is 00:00 UTC the next day.) Default
  is `trim = TRUE`.

- ignore_sensors:

  Vector of sensor serial numbers for sensors that are in the deployment
  log, but should NOT be compiled (e.g., data file missing).

- depth_override:

  An optional character string indicating which depth variable to
  compile. In some files (e.g., Borgles Island 2018-02-28), there is
  only one "Seawater depth" observation, but a full deployment of
  "Average seawater depth" observations. In this case, force the code to
  compile the average seawater depth with
  `depth_override = "Average seawater depth"`.

## Value

Returns a tibble of data from a sensor string deployment.

## Details

Reads the deployment log and then calls the `ss_compile_*_data()`,
functions and returns the results in a single data frame.

Data files must be in a folder named after the sensor manufacturer
and/or model (e.g., aquameasure, hobo, hobo_ph, vemco, vdat). Folder
names are not case sensitive. These folders must be in the same folder.

VR2AR data processed with the Fathom software must be in a folder called
vdat.

Columns with deployment details are added (e.g., county, waterbody,
latitude, longitude, station, lease, string_configuration).

## Examples

``` r
#path to the log, aquameasure, hobo, and vemco folders
path <- system.file("extdata", package = "sensorstrings")

dat <- ss_compile_deployment_data(path)
#> aquameasure data compiled
#> hobo data compiled
#> vemco data from sensor <<  547109  >> compiled: Temperature & Seawater depth
head(dat)
#> # A tibble: 6 × 17
#>   region county  waterbody station     lease latitude longitude deployment_range
#>   <lgl>  <chr>   <chr>     <chr>       <chr>    <dbl>     <dbl> <chr>           
#> 1 NA     Halifax Shoal Bay Borgles Is… NA        44.8     -62.7 2019-May-30 to …
#> 2 NA     Halifax Shoal Bay Borgles Is… NA        44.8     -62.7 2019-May-30 to …
#> 3 NA     Halifax Shoal Bay Borgles Is… NA        44.8     -62.7 2019-May-30 to …
#> 4 NA     Halifax Shoal Bay Borgles Is… NA        44.8     -62.7 2019-May-30 to …
#> 5 NA     Halifax Shoal Bay Borgles Is… NA        44.8     -62.7 2019-May-30 to …
#> 6 NA     Halifax Shoal Bay Borgles Is… NA        44.8     -62.7 2019-May-30 to …
#> # ℹ 9 more variables: string_configuration <chr>, sensor_type <chr>,
#> #   sensor_serial_number <dbl>, timestamp_utc <dttm>,
#> #   sensor_depth_at_low_tide_m <int>,
#> #   dissolved_oxygen_percent_saturation <dbl>, sensor_depth_measured_m <dbl>,
#> #   temperature_degree_c <dbl>, tilt_degree <dbl>

# leave the data untrimmed, and skip one of the sensors in the log
dat_untrimmed <- ss_compile_deployment_data(
  path, trim = FALSE, ignore_sensors = 547109
)
#> aquameasure data compiled
#> hobo data compiled
unique(dat_untrimmed$sensor_type)
#> [1] "hobo"        "aquameasure"
```
