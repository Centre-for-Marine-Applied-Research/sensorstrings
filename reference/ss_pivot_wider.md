# Pivot sensor string data from long to wide format

Pivot sensor string data from long to wide format

## Usage

``` r
ss_pivot_wider(dat_long)
```

## Arguments

- dat_long:

  Data frame of sensor string data in long format, as returned by
  [`ss_pivot_longer()`](https://centre-for-marine-applied-research.github.io/sensorstrings/reference/ss_pivot_longer.md).

## Value

Returns `dat_long` in wide format, with a separate column for each
`variable`.

## Examples

``` r
dat <- ss_compile_deployment_data(system.file("extdata", package = "sensorstrings"))
#> aquameasure data compiled
#> hobo data compiled
#> vemco data from sensor <<  547109  >> compiled: Temperature & Seawater depth

dat_long <- ss_pivot_longer(dat)

dat_wide <- ss_pivot_wider(dat_long)
head(dat_wide)
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
```
