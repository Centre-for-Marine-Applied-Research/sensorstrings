# Pivot sensor string data from long to wide format

Pivot sensor string data from long to wide format

## Usage

``` r
ss_pivot_longer(dat_wide)
```

## Arguments

- dat_wide:

  Data frame of sensor string data in a wide format, as returned by
  `ss_compile_**()` functions.

## Value

Returns `dat` in long format. Variables (e.g., temperature, dissolved,
salinity, and depth measured by sensor) are in a column named `variable`
and the associated measurement in a column named `value`.
