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

## Examples

``` r
# 3 depths: a 6-colour palette
ss_get_colour_palette(data.frame(sensor_depth_at_low_tide_m = c(2, 5, 15)))
#> [1] "#FDE725FF" "#7AD151FF" "#22A884FF" "#2A788EFF" "#414487FF" "#440154FF"

# 8 depths: one colour per depth
ss_get_colour_palette(data.frame(sensor_depth_at_low_tide_m = 1:8))
#> [1] "#FDE725FF" "#9FDA3AFF" "#4AC16DFF" "#1FA187FF" "#277F8EFF" "#365C8DFF"
#> [7] "#46337EFF" "#440154FF"
```
