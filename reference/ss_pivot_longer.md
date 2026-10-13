# Pivot sensor string data from wide to long format

Pivot sensor string data from wide to long format

## Usage

``` r
ss_pivot_longer(dat_wide)
```

## Arguments

- dat_wide:

  Data frame of sensor string data in a wide format, as returned by
  `ss_compile_*()` functions.

## Value

Returns `dat_wide` in long format. Variables (e.g., temperature,
dissolved oxygen, salinity, and depth measured by sensor) are in a
column named `variable` and the associated measurement in a column named
`value`.

## Examples

``` r
dat <- ss_compile_deployment_data(system.file("extdata", package = "sensorstrings"))
#> aquameasure data compiled
#> hobo data compiled
#> vemco data from sensor <<  547109  >> compiled: Temperature & Seawater depth

dat_long <- ss_pivot_longer(dat)

head(dat_long)
#> # A tibble: 6 × 15
#>   region county  waterbody station     lease latitude longitude deployment_range
#>   <lgl>  <chr>   <chr>     <chr>       <chr>    <dbl>     <dbl> <chr>           
#> 1 NA     Halifax Shoal Bay Borgles Is… NA        44.8     -62.7 2019-May-30 to …
#> 2 NA     Halifax Shoal Bay Borgles Is… NA        44.8     -62.7 2019-May-30 to …
#> 3 NA     Halifax Shoal Bay Borgles Is… NA        44.8     -62.7 2019-May-30 to …
#> 4 NA     Halifax Shoal Bay Borgles Is… NA        44.8     -62.7 2019-May-30 to …
#> 5 NA     Halifax Shoal Bay Borgles Is… NA        44.8     -62.7 2019-May-30 to …
#> 6 NA     Halifax Shoal Bay Borgles Is… NA        44.8     -62.7 2019-May-30 to …
#> # ℹ 7 more variables: string_configuration <chr>, sensor_type <chr>,
#> #   sensor_serial_number <dbl>, timestamp_utc <dttm>,
#> #   sensor_depth_at_low_tide_m <int>, variable <chr>, value <dbl>
unique(dat_long$variable)
#> [1] "temperature_degree_c"                "dissolved_oxygen_percent_saturation"
#> [3] "tilt_degree"                         "sensor_depth_measured_m"            
```
