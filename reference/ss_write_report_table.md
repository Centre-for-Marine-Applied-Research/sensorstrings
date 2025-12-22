# Writes deployment table for county report

Writes deployment table for county report

## Usage

``` r
ss_write_report_table(dat, keep_waterbody = FALSE, var_sep = "\n")
```

## Arguments

- dat:

  Data frame of sensor string data in wide format.

- keep_waterbody:

  Logical value indicating whether to keep the `Waterbody` column.

- var_sep:

  Separator between variables. Default will add a new line between
  variables for Word and pdf outputs.
