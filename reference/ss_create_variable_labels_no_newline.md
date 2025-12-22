# Create plot labels from variable names without new lines

Create plot labels from variable names without new lines

## Usage

``` r
ss_create_variable_labels_no_newline(dat)
```

## Arguments

- dat:

  Data frame of Water Quality data with variables in long format.
  Entries in `variable` column must be
  `dissolved_oxygen_percent_saturation`,
  `dissolved_oxygen_uncorrected_mg_per_l`, `salinity_psu`,
  `sensor_depth_measured_m`, or `temperature_degree_c`.

## Value

Returns `dat_long` with an addition column `variable_label`.
`variable_label`
