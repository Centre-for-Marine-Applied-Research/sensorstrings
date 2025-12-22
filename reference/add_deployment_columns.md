# Add and reorder columns

Add `deployment_range`, and `sensor_type`, `sensor_serial number`
columns. Rename `depth` column to `sensor_depth_at_low_tide_m`.

## Usage

``` r
add_deployment_columns(dat, start_date, end_date, sn_table)
```

## Arguments

- dat:

  placeholder

- start_date:

  placeholder

- end_date:

  placeholder

- sn_table:

  A data frame with three columns: `sensor_type`,
  `sensor_serial_number`, `depth`.

## Value

returns dat with additional columns
