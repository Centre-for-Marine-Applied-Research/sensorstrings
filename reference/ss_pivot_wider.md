# Pivot sensor string data from wide to long format

Pivot sensor string data from wide to long format

## Usage

``` r
ss_pivot_wider(dat_long)
```

## Arguments

- dat_long:

  Data frame of sensor string data in long format, as returned by
  [`ss_pivot_longer()`](https://dempsey-cmar.github.io/sensorstrings/reference/ss_pivot_longer.md).

## Value

Returns `dat_long` in wide format, with a separate column for each
`variable`.
