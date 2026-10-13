# Converts values in the depth column to an ordered factor

This function simplifies converting the sensor_depth_at_low_tide_m
column from class `numeric`, `factor`, or `character` to an ordered
factor, which is preferred for using the function
[`ss_ggplot_variables()`](https://centre-for-marine-applied-research.github.io/sensorstrings/reference/ss_ggplot_variables.md).

## Usage

``` r
ss_convert_depth_to_ordered_factor(dat)
```

## Arguments

- dat:

  Data frame that includes the column `sensor_depth_at_low_tide_m`.

## Value

Returns `dat`, with the `sensor_depth_at_low_tide_m` column converted to
an ordered factor. The shallowest depth will have a factor value of 1;
the deepest depth will have the largest factor value.

## Examples

``` r
dat <- data.frame(
  sensor_depth_at_low_tide_m = c(10, 2, 5, 2),
  temperature_degree_c = c(8, 15, 12, 14)
)

dat_ordered <- ss_convert_depth_to_ordered_factor(dat)

dat_ordered
#>   sensor_depth_at_low_tide_m temperature_degree_c
#> 1                          2                   15
#> 2                          2                   14
#> 3                          5                   12
#> 4                         10                    8
levels(dat_ordered$sensor_depth_at_low_tide_m)
#> [1] "2"  "5"  "10"
```
