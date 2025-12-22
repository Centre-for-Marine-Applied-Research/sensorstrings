# Extract units from column names of hobo pH data

Extract units from column names of hobo pH data

## Usage

``` r
extract_hobo_ph_units(dat)
```

## Arguments

- dat:

  Data as read in by `ss_read_hobo_ph_data()`.

## Value

Returns a tibble of `variable` and `units` found in `dat`. Units are ph
for pH and degree_c for temperature.
