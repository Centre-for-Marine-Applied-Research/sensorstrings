# Paste variable name and units to create column names

Paste variable name and units to create column names

## Usage

``` r
make_column_names(unit_table)
```

## Arguments

- unit_table:

  Data frame including columns `variable` and `units`, as returned from
  [`extract_hobo_units()`](https://dempsey-cmar.github.io/sensorstrings/reference/extract_hobo_units.md).

## Value

Data frame with column names in the form `variable_units`.
