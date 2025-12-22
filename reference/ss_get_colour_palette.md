# Returns colour palette based on the unique values of sensor_depth_at_low_tide_m

Returns colour palette based on the unique values of
sensor_depth_at_low_tide_m

## Usage

``` r
ss_get_colour_palette(dat)
```

## Arguments

- dat:

  Data frame with at least one column. The column name must include the
  string "low_tide".

## Value

Returns a vector of hex colours from the viridis palette (Option D,
direction = -1).

## Details

Returns a discrete colour scale palette from the viridis package (Option
D). If there are 6 or less unique values of
`sensor_depth_at_low_tide_m`, the palette will have 6 colours. If there
are more than 6 unique values of `sensor_depth_at_low_tide_m`, there
will be one colour for each depth.

## See also

Other plot:
[`ss_plot_variables()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_plot_variables.md)

## Author

Danielle Dempsey
