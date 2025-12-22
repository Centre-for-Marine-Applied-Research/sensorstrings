# Converts values in the depth column to an ordered factor

This function simplifies converting the sensor_depth_at_low_tide_m
column from class `numeric`, `factor`, or `character` to an ordered
factor, which is preferred for using the function
[`ss_ggplot_variables()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_ggplot_variables.md).

## Usage

``` r
ss_convert_depth_to_ordered_factor(dat)
```

## Arguments

- dat:

  Data frame that includes the column `sensor_depth_at_low_tide_m`.

## Value

Returns `dat`, with the `sensor_depth_at_low_tide_m` column converted to
an ordered factor. The shallowest depth with have a factor value of 1;
the deepest depth will have the largest factor value.

## Author

Danielle Dempsey
