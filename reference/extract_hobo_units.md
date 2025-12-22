# Extract units from column names of hobo data

Extract units from column names of hobo data

## Usage

``` r
extract_hobo_units(hobo_dat)
```

## Arguments

- hobo_dat:

  Data as read in by
  [`ss_read_hobo_data()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_read_hobo_data.md).

## Value

Returns a tibble of `variable` and `units` found in `hobo_dat`. Units
are mg_per_l for dissolved oxygen and degree_c for temperature.
